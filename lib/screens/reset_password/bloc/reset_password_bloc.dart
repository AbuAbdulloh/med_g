import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:med_g/models/register/register.dart';
import 'package:med_g/repository/authentication.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final AuthenticationRepository repository;
  ResetPasswordBloc({required this.repository})
      : super(
          ResetPasswordState(
            repository: repository,
            status: FormzStatus.pure,
            phone: '',
            signId: '',
            code: '',
          ),
        ) {
    on<SendPhone>((event, emit) async {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final response = await repository.registerUser(Register(
          firstName: '',
          password: '',
          phone: '998${event.phone}',
        ));
        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          phone: '998${event.phone}',
          signId: response.data!.signIn,
        ));
        event.onSucces();
      } catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
        event.onError('$e');
      }
    });
    on<VerifyPhone>((event, emit) async {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final data = await repository.verifyUser(
          code: event.pinCode,
          signId: state.signId,
        );
        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          code: event.pinCode,
        ));
        event.onSucces();
      } catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
        event.onError('$e');
      }
    });
    on<ChangePassword>((event, emit) async {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        repository.changePassword(
          code: state.code,
          password: event.newPassword,
          phone: state.phone,
          signId: state.signId,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
        event.onSucces();
      } catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
        event.onError('$e');
      }
    });
  }
}
