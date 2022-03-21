import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_g/data/utils/custom_exception.dart';
import 'package:med_g/models/authenticated_user/authenticated_user.dart';
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
            user: AuthenticatedUser.fromJson(const {}),
          ),
        ) {
    on<UserSignedUp>((event, emit) async {
      emit(state.copyWith(status: SubmissionStatus.submissionInProgress));
      try {
        if (event.register.firstName.isEmpty ||
            event.register.firstName.length < 5) {
          throw const CustomException(
            message: 'Ism yaroqli emas!',
            code: '400',
          );
        }
        if (event.register.phone.isEmpty || event.register.phone.length != 9) {
          throw const CustomException(
            message: 'Telefon raqami yaroqli emas!',
            code: '400',
          );
        }
        if (event.register.password.isEmpty ||
            event.register.password.length < 8) {
          throw const CustomException(
            message: 'Maxfiylik kaliti yaroqli emas!',
            code: '400',
          );
        }
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
        if (event.pinCode.isEmpty || event.pinCode.length != 6) {
          throw const CustomException(
            message: 'Kiritilgan kod yaroqli emas!',
            code: '400',
          );
        }
        final user = await repository.confirmUser(
          firstName: state.register.firstName,
          password: state.register.password,
          phone: state.register.phone,
          code: int.parse(
            event.pinCode,
            onError: (source) => 0,
          ),
          signId: state.registerResponse.data!.signIn,
        );
        emit(state.copyWith(
          status: SubmissionStatus.submissionSucces,
          user: user,
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
        if (event.phone.isEmpty) {
          throw const CustomException(
            message: 'Telefon raqami yaroqli emas!',
            code: '400',
          );
        }
        if (event.password.isEmpty || event.password.length < 8) {
          throw const CustomException(
            message: 'Maxfiylik kaliti yaroqli emas!',
            code: '400',
          );
        }
        await authenticationRepository.logIn(
          password: event.password,
          phoneNumber: '998' + event.phone.replaceAll(' ', '').trim(),
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
