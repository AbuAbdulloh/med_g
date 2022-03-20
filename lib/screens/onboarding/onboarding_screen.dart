import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/data/singletons/storage.dart';
import 'package:med_g/screens/home/home.dart';
import 'package:med_g/screens/onboarding/pages/first_page.dart';
import 'package:med_g/screens/onboarding/pages/second_page.dart';
import 'package:med_g/screens/onboarding/pages/third_page.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class OnboardingScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => const OnboardingScreen(),
      );
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;
  late PageView pageView;
  int currentIndex = 0;
  @override
  void initState() {
    pageController = PageController();
    pageView = PageView(
      controller: pageController,
      children: const [
        FirstPage(),
        SecondPage(),
        ThirdPage(),
      ],
    );
    pageController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: pageView,
          ),
          Positioned(
            bottom: 16 + mediaQuery.padding.bottom,
            left: 16,
            right: 16,
            child: WButton(
              onTap: () async {
                if (pageController.page!.toInt() == 0) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 650),
                    curve: Curves.linear,
                  );
                } else if (pageController.page!.toInt() == 1) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 650),
                    curve: Curves.linear,
                  );
                } else {
                  await StorageRepository.putBool(key: 'wizard', value: true);
                  Navigator.of(context).pushAndRemoveUntil<void>(
                      HomeScreen.route(), (route) => false);
                }
                setState(() {
                  currentIndex = pageController.page!.toInt();
                });
                print(currentIndex);
              },
              text: currentIndex == 1 ? 'Asosiyga o`tish' : 'Davom etish',
            ),
          ),
        ],
      ),
    );
  }
}
