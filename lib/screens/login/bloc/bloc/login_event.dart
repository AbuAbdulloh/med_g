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
