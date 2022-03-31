part of 'reset_password_bloc.dart';

class ResetPasswordState extends Equatable {
  final AuthenticationRepository repository;
  final FormzStatus status;
  final String phone;
  final String signId;
  final String code;
  const ResetPasswordState({
    required this.repository,
    required this.status,
    required this.phone,
    required this.signId,
    required this.code,
  });
  ResetPasswordState copyWith({
    AuthenticationRepository? repository,
    FormzStatus? status,
    String? phone,
    String? signId,
    String? code,
  }) {
    return ResetPasswordState(
      repository: repository ?? this.repository,
      status: status ?? this.status,
      phone: phone ?? this.phone,
      signId: signId ?? this.signId,
      code: code ?? this.code,
    );
  }

  @override
  List<Object> get props => [status, phone, signId,code];
}
