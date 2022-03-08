import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/bloc/bloc/authentication_bloc.dart';
import 'package:med_g/data/singletons/storage.dart';
import 'package:med_g/models/authentication_status/authentication_status.dart';
import 'package:med_g/repository/authentication.dart';
import 'package:med_g/screens/home/home.dart';
import 'package:med_g/screens/login/login_screen.dart';
import 'package:med_g/screens/onboarding/onboarding_screen.dart';
import 'package:med_g/screens/splash/splash_screen.dart';

class App extends StatefulWidget {
  final AuthenticationRepository authenticationRepository;
  const App({
    required this.authenticationRepository,
    Key? key,
  }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  late AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    super.initState();
    authenticationBloc = AuthenticationBloc(
      authenticationRepository: widget.authenticationRepository,
    );
  }
  @override
  Widget build(BuildContext context) => RepositoryProvider.value(
        value: widget.authenticationRepository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: authenticationBloc,
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MedG',
            theme: AppTheme.lightTheme(),
            onGenerateRoute: (settings) => SplashScreen.route(),
            navigatorKey: _navigatorKey,
            builder: (context, child) =>
                BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    if (!state.dontRebuild) {
                      _navigator.pushAndRemoveUntil<void>(
                        HomeScreen.route(),
                        (route) => false,
                      );
                    }
                    break;
                  case AuthenticationStatus.unauthenticated:
                    if (!StorageRepository.getBool('wizard', defValue: false)) {
                      _navigator.pushAndRemoveUntil<void>(
                        OnboardingScreen.route(),
                        (route) => false,
                      );
                    } else {
                      if (StorageRepository.getString('token', defValue: '') ==
                          '') {
                        _navigator.pushAndRemoveUntil<void>(
                          HomeScreen.route(),
                          (route) => false,
                        );
                      } else {
                        context.read<AuthenticationBloc>().add(
                          AuthenticationGetStatus(
                            () {
                              _navigator.pushAndRemoveUntil(
                                HomeScreen.route(),
                                (route) => false,
                              );
                            },
                          ),
                        );
                      }
                    }
                    break;
                  case AuthenticationStatus.unknown:
                    _navigator.pushAndRemoveUntil<void>(
                      HomeScreen.route(),
                      (route) => false,
                    );
                    break;
                  default:
                    break;
                }
              },
              child: child!,
            ),
          ),
        ),
      );
}
