part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class SendPhone extends ResetPasswordEvent {
  final String phone;
  final Function() onSucces;
  final Function(String message) onError;
  const SendPhone({
    required this.phone,
    required this.onSucces,
    required this.onError,
  });
}

class VerifyPhone extends ResetPasswordEvent {
  final String pinCode;
  final Function() onSucces;
  final Function(String message) onError;

  const VerifyPhone({
    required this.pinCode,
    required this.onSucces,
    required this.onError,
  });
}

class ChangePassword extends ResetPasswordEvent {
  final String newPassword;
  final String confirmNewPassword;
  final Function() onSucces;
  final Function(String message) onError;

  const ChangePassword({
    required this.newPassword,
    required this.confirmNewPassword,
    required this.onSucces,
    required this.onError,
  });
}
