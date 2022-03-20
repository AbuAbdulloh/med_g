import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/app/theme/theme.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SvgPicture.asset(
                AppIcons.onboard_3,
                fit: BoxFit.fill,
                color: red,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppIcons.onboard3),
              const SizedBox(height: 20),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Order Medicine Online',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Text(
                      'Order your medicine that your doctor provided you...',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
