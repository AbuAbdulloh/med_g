part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = const AuthenticatedUser(
      activatedAt: '',
      address: '',
      allergy: '',
      birthDate: '',
      createdAt: '',
      firstName: '',
      height: 0,
      hobby: '',
      id: '',
      image: '',
      password: '',
      patronymic: '',
      phone: '',
      status: 0,
      surname: '',
      updatedAt: '',
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
