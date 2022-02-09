import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/screens/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      );
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          OnboardingScreen.route(),
          (route) => false,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blue,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            alignment: Alignment.center,
            child: SvgPicture.asset(AppIcons.logo),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: SvgPicture.asset(AppIcons.logoBig),
          )
        ],
      ),
    );
  }
}
