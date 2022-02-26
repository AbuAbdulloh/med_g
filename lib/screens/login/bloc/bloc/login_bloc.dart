import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_g/models/register/register.dart';
import 'package:med_g/models/register_response/register_response.dart';
import 'package:med_g/models/submission_status/submission_status.dart';
import 'package:med_g/repository/authentication.dart';
import 'package:med_g/repository/register.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final repository = RegisterRepository();
  final authenticationRepository = AuthenticationRepository();
  LoginBloc()
      : super(
          LoginState(
            status: SubmissionStatus.pure,
            register: Register.fromJson(const {}),
            registerResponse: RegisterResponse.fromJson(const {}),
          ),
        ) {
    on<UserSignedUp>((event, emit) async {
      emit(state.copyWith(status: SubmissionStatus.submissionInProgress));
      try {
        final registerResponse = await repository.registerUser(event.register);
        emit(state.copyWith(
          status: SubmissionStatus.submissionSucces,
          register: event.register,
          registerResponse: registerResponse,
        ));
        event.onSucces();
      } on Exception catch (e) {
        emit(state.copyWith(status: SubmissionStatus.submissionFailure));
        event.onError('$e');
      }
    });
    on<UserVerified>((event, emit) async {
      emit(state.copyWith(status: SubmissionStatus.submissionInProgress));
      try {
        await repository.confirmUser(
          code: int.parse(
            event.pinCode,
            onError: (source) => 0,
          ),
          signId: state.registerResponse.data!.signIn,
          userId: state.registerResponse.data!.userId,
        );
        emit(state.copyWith(
          status: SubmissionStatus.submissionSucces,
        ));
        event.onSucces();
      } catch (e) {
        emit(state.copyWith(status: SubmissionStatus.submissionFailure));
        event.onError('$e');
      }
    });
    on<UserLoggedIn>((event, emit) async {
      emit(state.copyWith(status: SubmissionStatus.submissionInProgress));
      try {
        await authenticationRepository.logIn(
          password: event.password,
          phoneNumber: '998' +
              event.phone
                  .replaceAll('-', '')
                  .replaceAll('(', '')
                  .replaceAll(')', '')
                  .replaceAll(' ', '')
                  .trim(),
        );
        emit(state.copyWith(status: SubmissionStatus.submissionSucces));
        event.onSucces();
      } on Exception catch (e) {
        emit(state.copyWith(status: SubmissionStatus.submissionFailure));
        event.onError('$e');
      }
    });
  }
}
