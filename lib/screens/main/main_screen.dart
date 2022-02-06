import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/screens/main/widgets/menu_item.dart';
import 'package:med_g/screens/reviews/reviews_screen.dart';
import 'package:med_g/widgets/w_notifications_button.dart';
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
      ),
      child: Scaffold(
        backgroundColor: AppTheme.background,
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
                  'Привет, Lucy Martin',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const WNotificationsButton(),
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
                  'Приветствуем тебя на твоей страничке здоровья!!!',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
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
                        color: AppTheme.primaryText,
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
                                    ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Get your medicine at home by online order...',
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
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
                    activeDotColor: AppTheme.primaryText,
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
                  'Функции',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
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
                        title: 'Советы',
                        icon: AppIcons.heart,
                        onTap: () {
                          Navigator.of(context).push(ReviewsScreen.route());
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: MenuItem(
                        title: 'Психология',
                        icon: AppIcons.liver,
                        isActive: true,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: MenuItem(
                        title: 'Дневник',
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
                        title: 'Спорт',
                        icon: AppIcons.health,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: MenuItem(
                        title: 'Анатомия',
                        icon: AppIcons.baby,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: MenuItem(
                        title: 'Поддержка',
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
