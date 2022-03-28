import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:med_g/data/singletons/storage.dart';
import 'package:med_g/models/authenticated_user/authenticated_user.dart';
import 'package:med_g/models/authentication_status/authentication_status.dart';
import 'package:med_g/repository/authentication.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationLogoutRequested>((event, emit) async {
      await _authenticationRepository.logOut();
      emit(const AuthenticationState.unauthenticated());
    });

    on<AuthenticationGetRefreshedUserData>((event, emit) async {
      try {
        await _authenticationRepository.refreshToken();
        print('came here');
        add(const AuthenticationStatusChanged(
          AuthenticationStatus.authenticated,
        ));
      } on Exception {
        print('came here to fail');
        emit(const AuthenticationState.unknown());
      }
    });

    on<AuthenticationStatusChanged>((event, emit) async {
      switch (event.status) {
        case AuthenticationStatus.unauthenticated:
          emit(const AuthenticationState.unauthenticated());
          break;
        case AuthenticationStatus.authenticated:
          final user = await _tryGetUser();

          if (user != null) {
            emit(AuthenticationState.authenticated(user));
          } else {
            emit(const AuthenticationState.unauthenticated());
          }
          break;
        default:
          emit(const AuthenticationState.unknown());
      }
    });

    on<AuthenticationGetStatus>((event, emit) async {
      try {
        await _authenticationRepository.getProfile();
        add(
          const AuthenticationStatusChanged(AuthenticationStatus.authenticated),
        );
      } on Exception {
        add(AuthenticationGetRefreshedUserData());
      }
    });
    on<AuthenticationUserDeleted>((event, emit) async {
      await StorageRepository.putString('token', '');
      await StorageRepository.putString('refresh', '');
      emit(const AuthenticationState.unknown());
    });

    _authenticationStatusSubscription = _authenticationRepository.status
        .listen((status) => add(AuthenticationStatusChanged(status)));
  }

  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<AuthenticatedUser?> _tryGetUser() async {
    try {
      final user = await _authenticationRepository.getProfile();
      return user;
    } on Exception {
      return null;
    }
  }
}
