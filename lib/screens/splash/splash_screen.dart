import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';

class SplashScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      );
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 20),
          Align(child: SvgPicture.asset(AppIcons.logoBig)),
          const Padding(
            padding: EdgeInsets.only(bottom: 32),
            child: CupertinoActivityIndicator(),
          ),
        ],
      ),
    );
  }
}
