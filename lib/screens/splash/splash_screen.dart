import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/app/theme/theme.dart';

class SplashScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      );
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
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
