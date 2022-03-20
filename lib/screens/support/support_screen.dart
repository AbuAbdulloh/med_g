import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/screens/support/widgets/support_detail.dart';
import 'package:med_g/widgets/w_app_bar.dart';
import 'package:med_g/widgets/w_forward_button.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class SupportScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => const SupportScreen(),
      );
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: background,
      appBar: PreferredSize(
        child: WAppBar(
          title: 'Support',
          mediaQuery: mediaQuery,
        ),
        preferredSize: Size.fromHeight(mediaQuery.padding.top + 77),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(12, 26, 10, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return SupportItem(
                  title: 'How to delete account?',
                  onTap: () {
                    Navigator.of(context).push(SupprotDetail.route());
                  },
                );
              },
              separatorBuilder: (_, __) {
                return const SizedBox(height: 21);
              },
              itemCount: 4,
            ),
            const SizedBox(height: 33),
            const OwnerInfoCard(
              title: 'Dr. Roboto Kale',
              officeHours: '9:00  -  11:00 AM',
              position: 'Heart Surgeon - Apollo Hospital',
              icon: 'assets/icons/mail_doctor.png',
            ),
            const SizedBox(height: 20),
            const OwnerInfoCard(
              title: 'Dr. Lily Rozar',
              officeHours: '9:00  -  11:00 AM',
              position: 'Neurologist - VS Hospital',
              icon: 'assets/icons/female_doctor.png',
            ),
          ],
        ),
      ),
    );
  }
}

class OwnerInfoCard extends StatelessWidget {
  final String title;
  final String position;
  final String officeHours;
  final String icon;

  const OwnerInfoCard({
    required this.officeHours,
    required this.position,
    required this.title,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
            Container(
              width: 89,
              height: 89,
              decoration: const BoxDecoration(
                color: dark,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Image.asset(icon),
            ),
            const SizedBox(width: 21),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  position,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      height: 19,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 0,
                      ),
                      decoration: const BoxDecoration(
                        color: red,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '4.5',
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                          SvgPicture.asset(AppIcons.star),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    SvgPicture.asset(AppIcons.clock),
                    const SizedBox(width: 5),
                    Text(
                      officeHours,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      onTap: () {},
    );
  }
}

class SupportItem extends StatelessWidget {
  final String title;
  final Function() onTap;
  const SupportItem({
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        width: double.maxFinite,
        height: 64,
        decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            const WForwardButton(),
          ],
        ),
      ),
    );
  }
}
