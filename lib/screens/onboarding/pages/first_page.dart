import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

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
                AppIcons.onboard_1,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppIcons.onboard1),
              const SizedBox(height: 20),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Find Your Doctor Online',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Text(
                      'Find a doctor who will take the best care of your health...',
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
