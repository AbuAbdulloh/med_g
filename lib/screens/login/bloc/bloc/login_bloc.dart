import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_g/models/register/register.dart';
import 'package:med_g/models/register_response/register_response.dart';
import 'package:med_g/models/submission_status/submission_status.dart';
import 'package:med_g/repository/register.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final repository = RegisterRepository();
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
          registerResponse: registerResponse,
        ));
        event.onSucces();
      } on Exception catch (e) {
        emit(state.copyWith(status: SubmissionStatus.submissionFailure));
        event.onError('$e');
      }
    });
  }
}
