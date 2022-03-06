import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/bloc/bloc/authentication_bloc.dart';
import 'package:med_g/models/authentication_status/authentication_status.dart';
import 'package:med_g/screens/account_settings/account_settings_screen.dart';
import 'package:med_g/screens/login/login_screen.dart';
import 'package:med_g/screens/notifications/notifications_screen.dart';
import 'package:med_g/screens/privacy/privacy_screen.dart';
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
        onTap: () {
          Navigator.of(context).push(PrivacyScreen.route());
        },
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
    final theme = Theme.of(context).textTheme;
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return Scaffold(
            backgroundColor: AppTheme.background,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(mediaQuery.padding.top + 264),
              child: ProfileAppBar(mediaQuery: mediaQuery),
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppTheme.black,
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.brown,
                          //     blurRadius: 5,
                          //     spreadRadius: 5,
                          //   )
                          // ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lucy Martin',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '+998901234567',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      // Positioned(
                      //   right: 0,
                      //   bottom: 0,
                      //   child: Container(
                      //     width: 39,
                      //     height: 39,
                      //     padding: const EdgeInsets.all(8),
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       color: AppTheme.redAccent,
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: AppTheme.redAccent.withOpacity(0.7),
                      //           blurRadius: 5,
                      //           offset: const Offset(2, 2),
                      //         ),
                      //       ],
                      //     ),
                      //     child: SvgPicture.asset(AppIcons.camera),
                      //   ),
                      // )
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(13.5, 0, 13.5, 13.5),
                  itemBuilder: (_, index) => ProfileItem(
                    icon: profileItems[index].icon,
                    title: profileItems[index].title,
                    onTap: profileItems[index].onTap,
                    isActive: profileItems[index].isActive,
                  ),
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemCount: profileItems.length,
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcons.noAccount),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Для полноценного использования войдите в аккаунт',
                          style: theme.headline1!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                WButton(
                  margin: const EdgeInsets.all(16),
                  text: 'Войти',
                  textStyle: theme.headline2!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .push(LoginScreen.route());
                  },
                )
              ],
            ),
          );
        }
      },
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
      color: isActive ? AppTheme.primaryText : AppTheme.white,
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
              color: isActive ? AppTheme.main : AppTheme.white,
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
