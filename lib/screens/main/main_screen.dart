import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/screens/main/widgets/article_item.dart';
import 'package:med_g/screens/main/widgets/category_item.dart';
import 'package:med_g/screens/main/widgets/main_app_bar.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late TextEditingController searchController;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: background,
        body: NestedScrollView(
          headerSliverBuilder: (_, __) => [
            MainAppBar(searchController: searchController),
          ],
          body: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Turkumlar',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              SizedBox(
                height: 186,
                child: ListView.separated(
                  clipBehavior: Clip.none,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(
                      left: 16, top: 12, bottom: 8, right: 16),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => const CategoryItem(),
                  separatorBuilder: (_, __) => const SizedBox(width: 4),
                  itemCount: 5,
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: 16),
                  Text(
                    'So’nggi maqolalar',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Spacer(),
                  WScaleAnimation(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Barcha maqolalar',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                physics: const ClampingScrollPhysics(),
                itemBuilder: (_, index) => const ArticleItem(),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemCount: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
