part of 'login_bloc.dart';

class LoginState extends Equatable {
  final SubmissionStatus status;
  final Register register;
  final RegisterResponse registerResponse;

  const LoginState({
    required this.status,
    required this.register,
    required this.registerResponse,
  });

  LoginState copyWith({
    SubmissionStatus? status,
    Register? register,
    RegisterResponse? registerResponse,
  }) =>
      LoginState(
        status: status ?? this.status,
        register: register ?? this.register,
        registerResponse: registerResponse ?? this.registerResponse,
      );

  @override
  List<Object?> get props => [status, register, registerResponse];
}
