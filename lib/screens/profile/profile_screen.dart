import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/screens/account_settings/account_settings_screen.dart';
import 'package:med_g/screens/notifications/notifications_screen.dart';
import 'package:med_g/screens/profile/widgets/profile_app_bar.dart';
import 'package:med_g/screens/support/support_screen.dart';
import 'package:med_g/widgets/w_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late List<ProfileItemModel> profileItems;

  @override
  void initState() {
    super.initState();
    profileItems = [
      ProfileItemModel(
        title: 'Account Settings',
        icon: AppIcons.edit,
        onTap: () {
          Navigator.of(context).push(AccountSettings.route());
        },
      ),
      ProfileItemModel(
          title: 'Notification',
          icon: AppIcons.notifications,
          onTap: () {
            Navigator.of(context).push(
              NotificationsScreen.route(),
            );
          },
          isActive: true),
      ProfileItemModel(
        title: 'Support',
        icon: AppIcons.support,
        onTap: () {
          Navigator.of(context).push(
            SupportScreen.route(),
          );
        },
      ),
      ProfileItemModel(
        title: 'Privacy Policy',
        icon: AppIcons.privacy,
        onTap: () {},
      ),
      ProfileItemModel(
        title: 'Logout',
        icon: AppIcons.logout,
        onTap: () {},
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppTheme.cF3F8FF,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mediaQuery.padding.top + 264),
        child: ProfileAppBar(mediaQuery: mediaQuery),
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: const EdgeInsets.fromLTRB(13.5, 20, 13.5, 13.5),
        itemBuilder: (_, index) => ProfileItem(
          icon: profileItems[index].icon,
          title: profileItems[index].title,
          onTap: profileItems[index].onTap,
          isActive: profileItems[index].isActive,
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: profileItems.length,
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String icon;
  final String title;
  final Function() onTap;
  final bool isActive;
  const ProfileItem({
    required this.icon,
    required this.title,
    required this.onTap,
    required this.isActive,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WButton(
      color: isActive ? AppTheme.c1479FF : AppTheme.white,
      onTap: onTap,
      height: 65,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 21),
            padding: const EdgeInsets.all(10),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isActive ? AppTheme.c1D3A62 : AppTheme.white,
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
            child: SvgPicture.asset(icon),
          ),
          Expanded(
            child: Text(
              title,
              style: isActive
                  ? Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )
                  : Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
            ),
          ),
          SvgPicture.asset(
            AppIcons.arrowForwardIos,
            color: isActive ? AppTheme.white : null,
          )
        ],
      ),
    );
  }
}

class ProfileItemModel {
  final String title;
  final String icon;
  final Function() onTap;
  final bool isActive;

  ProfileItemModel({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isActive = false,
  });
}
