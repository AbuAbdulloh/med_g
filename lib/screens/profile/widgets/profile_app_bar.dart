
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    Key? key,
    required this.mediaQuery,
  }) : super(key: key);

  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mediaQuery.padding.top + 264,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: AppTheme.c1479FF,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: mediaQuery.padding.top,
              left: 14,
              right: 14,
            ),
            height: mediaQuery.padding.top + 77,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.black.withOpacity(0.1),
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  child: WButton(
                    padding: EdgeInsets.zero,
                    color: AppTheme.white,
                    onTap: () {},
                    width: 31,
                    height: 31,
                    child: SvgPicture.asset(AppIcons.arrowBackIos),
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
                      ],
                    ),
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
                ),
              ],
            ),
          ),
          Positioned(
            top: mediaQuery.padding.top + 17,
            left: (mediaQuery.size.width / 2) - 75,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 165,
                  height: 165,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.2),
                        blurRadius: 5,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: AppTheme.white,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 39,
                          height: 39,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.redAccent,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.redAccent.withOpacity(0.7),
                                blurRadius: 5,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(AppIcons.camera),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Lucy Martin',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Text(
                  '+998901234567',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
