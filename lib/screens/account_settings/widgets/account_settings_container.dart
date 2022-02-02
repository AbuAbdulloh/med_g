
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class AccountSettingsContainer extends StatelessWidget {
  final String title;
  final Function() onEditTap;
  final List<Widget> items;
  const AccountSettingsContainer({
    required this.title,
    required this.onEditTap,
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: AppTheme.background,
        boxShadow: [
          BoxShadow(
            color: AppTheme.black.withOpacity(0.3),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 17,
                  ),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                WScaleAnimation(
                  onTap: (_) {
                    onEditTap();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 17,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.edit,
                          width: 11,
                          height: 11,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Edit',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(18, 28, 18, 12),
            child: Column(mainAxisSize: MainAxisSize.min, children: items),
          )
        ],
      ),
    );
  }
}
