import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/screens/main/widgets/menu_item.dart';
import 'package:med_g/widgets/w_scale_animation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late CarouselController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CarouselController();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppTheme.cF3F8FF,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            56 + mediaQuery.padding.top,
          ),
          child: Container(
            padding: EdgeInsets.only(
              top: mediaQuery.padding.top,
              left: 15,
              right: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hi, Lucy Martin',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.c1D3A62,
                      ),
                ),
                WScaleAnimation(
                  onTap: (value) {},
                  child: Container(
                    width: 42,
                    height: 42,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: AppTheme.white.withOpacity(0.35),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.c1479FF.withOpacity(0.35),
                            blurRadius: 35,
                            spreadRadius: 0,
                            offset: const Offset(0, 15),
                          )
                        ]),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: const BoxDecoration(
                        color: AppTheme.white,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        AppIcons.bellRed,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 14),
                child: Text(
                  'Find Your Medical Solution!',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.c1D3A62,
                      ),
                ),
              ),
              CarouselSlider.builder(
                carouselController: _controller,
                itemCount: 5,
                itemBuilder: (_, __, ___) {
                  return WScaleAnimation(
                    onTap: (value) {},
                    child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.c1479FF,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Medicine',
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      fontSize: 33,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.white,
                                    ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Get your medicine at home by online order...',
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.white,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 147,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(height: 16),
              Align(
                child: AnimatedSmoothIndicator(
                  activeIndex: currentIndex,
                  count: 5,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: AppTheme.c1479FF,
                    dotColor: AppTheme.cB4C7DE,
                    radius: 6,
                    dotWidth: 6,
                    dotHeight: 6,
                    spacing: 5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14, top: 28, bottom: 12),
                child: Text(
                  'Services',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.c1D3A62,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MenuItem(
                        title: 'Cardiologist',
                        icon: AppIcons.heart,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: MenuItem(
                        title: 'Gastrologist',
                        icon: AppIcons.liver,
                        isActive: true,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: MenuItem(
                        title: 'Neurologist',
                        icon: AppIcons.brain,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14, top: 10, right: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MenuItem(
                        title: 'Psychologist',
                        icon: AppIcons.health,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: MenuItem(
                        title: 'Pediatrician',
                        icon: AppIcons.baby,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: MenuItem(
                        title: 'Surgeons',
                        icon: AppIcons.surgery,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
