part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = const AuthenticatedUser(
      address: '',
      allergy: '',
      birthDate: '',
      firstName: '',
      height: 0,
      hobby: '',
      id: '',
      image: '',
      patronymic: '',
      phone: '',
      status: 0,
      weight: 0,
    ),
    this.dontRebuild = false,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(
    AuthenticatedUser user, {
    bool dontRebuild = false,
  }) : this._(
          status: AuthenticationStatus.authenticated,
          user: user,
          dontRebuild: dontRebuild,
        );

  const AuthenticationState.unauthenticated()
      : this._(
          status: AuthenticationStatus.unauthenticated,
        );

  final AuthenticationStatus status;
  final AuthenticatedUser user;
  final bool dontRebuild;

  @override
  List<Object> get props => [status, user, dontRebuild];
}
