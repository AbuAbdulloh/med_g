import 'package:flutter/material.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/widgets/w_back_button.dart';
import 'package:med_g/widgets/w_notifications_button.dart';

class WAppBar extends StatelessWidget {
  final String title;
  final bool hasNotificationsButton;
  const WAppBar({
    required this.title,
    this.hasNotificationsButton = true,
    Key? key,
    required this.mediaQuery,
  }) : super(key: key);

  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mediaQuery.padding.top + 77,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: AppTheme.primaryText,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
      child: Container(
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
          // boxShadow: [
          //   BoxShadow(
          //     color: AppTheme.black.withOpacity(0.3),
          //     blurRadius: 5,
          //     offset: const Offset(0, 1),
          //   ),
          // ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const WBackButton(),
            Text(
              title,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            if (hasNotificationsButton) ...{
              const WNotificationsButton(),
            } else ...{
              const SizedBox(width: 24, height: 24),
            }
          ],
        ),
      ),
    );
  }
}
