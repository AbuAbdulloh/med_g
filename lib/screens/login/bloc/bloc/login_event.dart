part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserSignedUp extends LoginEvent {
  final Register register;
  final Function() onSucces;
  final Function(String message) onError;
  UserSignedUp({
    required this.register,
    required this.onSucces,
    required this.onError,
  });

  @override
  List<Object?> get props => [];
}

class UserVerified extends LoginEvent {
  final String pinCode;
  final Function() onSucces;
  final Function(String message) onError;
  UserVerified({
    required this.pinCode,
    required this.onSucces,
    required this.onError,
  });

  @override
  List<Object?> get props => [];
}

class UserLoggedIn extends LoginEvent {
  final String phone;
  final String password;
  final Function() onSucces;
  final Function(String message) onError;
  UserLoggedIn({
    required this.phone,
    required this.password,
    required this.onSucces,
    required this.onError,
  });
}
