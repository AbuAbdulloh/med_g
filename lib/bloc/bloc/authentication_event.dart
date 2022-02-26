part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus status;

  const AuthenticationStatusChanged(this.status);

  @override
  List<Object> get props => [status];
}

class ChangeLanguageEvent extends AuthenticationEvent {
  final String language;

  const ChangeLanguageEvent(this.language);

  @override
  List<Object> get props => [language];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {
  final Function() onSucces;
  final Function(String message) onError;

  const AuthenticationLogoutRequested({
    required this.onSucces,
    required this.onError,
  });
}

class AuthenticationGetStatus extends AuthenticationEvent {
  final Function onFail;

  const AuthenticationGetStatus(this.onFail);

  @override
  List<Object> get props => [onFail];
}

class AuthenticationGetRefreshedUserData extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class AuthenticationUserSwitched extends AuthenticationEvent {
  final AuthenticatedUser user;
  final Function() onSucces;
  final Function(String message) onError;
  const AuthenticationUserSwitched({
    required this.user,
    required this.onSucces,
    required this.onError,
  });
  @override
  List<Object> get props => [user, onSucces, onError];
}

class AuthenticationUserDeleted extends AuthenticationEvent {
  final int id;
  final Function(String message) onError;

  const AuthenticationUserDeleted({
    required this.id,
    required this.onError,
  });

  @override
  List<Object> get props => [id, onError];
}
