import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/screens/reviews/widgets/review_item.dart';
import 'package:med_g/screens/support/bloc/support_detail_item.dart';
import 'package:med_g/widgets/w_app_bar.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:med_g/widgets/w_scale_animation.dart';
import 'package:med_g/widgets/w_textfield.dart';

class ReviewsScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => const ReviewsScreen(),
      );
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  late ScrollController _controller;
  late TextEditingController _searchController;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return KeyboardDismisser(
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _controller,
          slivers: [
            SliverAppBar(
              elevation: 0,
              pinned: true,
              automaticallyImplyLeading: false,
              toolbarHeight: 77,
              expandedHeight: mediaQuery.padding.top + 201,
              backgroundColor: Colors.transparent,
              flexibleSpace: LayoutBuilder(
                builder: (_, constraints) {
                  return AnimatedCrossFade(
                    firstChild:
                        WAppBar(title: 'Reviews', mediaQuery: mediaQuery),
                    secondChild: Wrap(
                      children: [
                        Container(
                          height: mediaQuery.padding.top + 201,
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              WAppBar(title: 'Reviews', mediaQuery: mediaQuery),
                              const SizedBox(height: 14),
                              Padding(
                                padding: const EdgeInsets.all(14),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppTheme.black
                                                  .withOpacity(0.1),
                                              blurRadius: 2,
                                              offset: const Offset(1, 1),
                                            )
                                          ],
                                        ),
                                        child: WTextField(
                                          borderRadius: 8,
                                          fillColor: AppTheme.white,
                                          controller: _searchController,
                                          onChanged: (_) {},
                                          prefix: Padding(
                                            padding: const EdgeInsets.all(14),
                                            child: SvgPicture.asset(
                                                AppIcons.search),
                                          ),
                                          suffix: WScaleAnimation(
                                            onTap: (_) {
                                              _searchController.clear();
                                            },
                                            child: SvgPicture.asset(
                                              AppIcons.closeGreen,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    WButton(
                                      margin: const EdgeInsets.only(left: 11),
                                      padding: const EdgeInsets.all(16),
                                      onTap: () {},
                                      child: SvgPicture.asset(AppIcons.filter),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    crossFadeState:
                        constraints.maxHeight == (mediaQuery.padding.top + 77)
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 250),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: ListView.separated(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                shrinkWrap: true,
                itemBuilder: (_, index) => ReviewItem(
                  name: 'Mikey Lecan ',
                  time: '20 minutes ago',
                  items: [
                    Text(
                      'Simply dummy text of the printing and types etting when an unknown industry but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing randomised words which dont look even slightly believable. Many desktop publishing packages and web page editors now use search for lorem ipsum will uncover many websites.',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(),
                    ),
                  ],
                ),
                separatorBuilder: (_, __) => const SizedBox(
                  height: 10,
                ),
                itemCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
