import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/repository/authentication.dart';
import 'package:med_g/screens/login/login_screen.dart';
import 'package:med_g/screens/login/signup_screen.dart';
import 'package:med_g/widgets/w_button.dart';

class DirectorScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => const DirectorScreen(),
      );
  const DirectorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: mediaQuery.size.height / 2 - 132,
            child: SvgPicture.asset(
              AppIcons.vectors,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(14, mediaQuery.padding.top, 14, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35),
                Text(
                  'Need',
                  style: theme.headline2!.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Medical Help?',
                  style: theme.headline2!.copyWith(
                    fontSize: 47,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Let\'s start discuss with us!',
                  style: theme.headline2!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                WButton(
                  color: primary,
                  margin: const EdgeInsets.only(bottom: 16),
                  text: 'Create an account',
                  textStyle: theme.headline2!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => SignupScreen(
                            authenticationRepository:
                                RepositoryProvider.of<AuthenticationRepository>(
                                    context)),
                      ),
                      (route) => false,
                    );
                  },
                ),
                WButton(
                  color: white,
                  margin: const EdgeInsets.only(bottom: 16),
                  text: 'Sign In',
                  textStyle: theme.headline1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => LoginScreen(
                            authenticationRepository:
                                RepositoryProvider.of<AuthenticationRepository>(
                                    context)),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
