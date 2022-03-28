import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/widgets/w_app_bar.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class NotificationsScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => const NotificationsScreen(),
      );
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: background,
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: const EdgeInsets.only(top: 38, left: 14, right: 14),
        children: const [
          NotificationsList(),
          NotificationsList(),
          NotificationsList(),
        ],
      ),
    );
  }
}

class NotificationsList extends StatelessWidget {
  const NotificationsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today',
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 10),
          ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (_, index) => const NotificationItem(),
            separatorBuilder: (_, index) => const SizedBox(height: 21),
            itemCount: 4,
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 17,
        ),
        decoration: const BoxDecoration(color: white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WButton(
              color: primary,
              onTap: () {},
              child: SvgPicture.asset(AppIcons.notificationsRotated),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'From Dr. Merry',
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '11 Min',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'Many desktop publishing packages and web page editors now use Lorem',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
