part of 'login_bloc.dart';

class LoginState extends Equatable {
  final SubmissionStatus status;
  final Register register;
  final RegisterResponse registerResponse;
  final AuthenticatedUser user;
  const LoginState({
    required this.user,
    required this.status,
    required this.register,
    required this.registerResponse,
  });

  LoginState copyWith(
          {SubmissionStatus? status,
          Register? register,
          RegisterResponse? registerResponse,
          AuthenticatedUser? user}) =>
      LoginState(
        status: status ?? this.status,
        register: register ?? this.register,
        registerResponse: registerResponse ?? this.registerResponse,
        user: user ?? this.user,
      );

  @override
  List<Object?> get props => [status, register, registerResponse, user];
}
