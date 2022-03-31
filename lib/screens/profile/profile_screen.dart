import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/bloc/bloc/authentication_bloc.dart';
import 'package:med_g/models/authentication_status/authentication_status.dart';
import 'package:med_g/repository/authentication.dart';
import 'package:med_g/screens/about/about_screen.dart';
import 'package:med_g/screens/account_settings/account_settings_screen.dart';
import 'package:med_g/screens/login/login_screen.dart';
import 'package:med_g/screens/profile/widgets/profile_item.dart';
import 'package:med_g/screens/saved/saved_screen.dart';
import 'package:med_g/widgets/cached_image.dart';
import 'package:med_g/widgets/language_bottomsheet.dart';
import 'package:med_g/widgets/w_app_bar.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:med_g/widgets/w_error_snack_bar.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return Scaffold(
            backgroundColor: background,
            appBar: const WAppBar(
              title: 'Profil',
            ),
            body: Column(
              children: [
                ProfileItem(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  leading: Container(
                    clipBehavior: Clip.hardEdge,
                    width: 49,
                    height: 49,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: CachedImage(
                      fit: BoxFit.cover,
                      url: context.read<AuthenticationBloc>().state.user.image,
                      width: 49,
                      height: 49,
                    ),
                  ),
                  trailing: SvgPicture.asset(AppIcons.arrowForwardIos),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.read<AuthenticationBloc>().state.user.firstName,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '+${MaskTextInputFormatter(mask: '### ## ### ## ##', initialText: context.read<AuthenticationBloc>().state.user.phone, type: MaskAutoCompletionType.eager).getMaskedText()}',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const AccountSettings(),
                    ));
                  },
                  height: 73,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfileItem(
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        leading: SizedBox(
                          width: 24,
                          height: 24,
                          child: SvgPicture.asset(AppIcons.logoAlone),
                        ),
                        trailing: const SizedBox(),
                        title: Text(
                          'MedG haqida',
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          Navigator.of(context).push(AboutScreen.route());
                        },
                        height: 56,
                      ),
                      ProfileItem(
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        leading: SizedBox(
                          width: 24,
                          height: 24,
                          child: SvgPicture.asset(
                            AppIcons.support,
                            color: dark,
                          ),
                        ),
                        trailing: const SizedBox(),
                        title: Text(
                          'Qo’llab-quvvatlash',
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {},
                        height: 56,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfileItem(
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        leading: SizedBox(
                          width: 24,
                          height: 24,
                          child: SvgPicture.asset(AppIcons.globe),
                        ),
                        trailing: const SizedBox(),
                        title: Text(
                          'Tilni o’zgartirish',
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          showLanguageBottomSheet(context);
                        },
                        height: 56,
                      ),
                      ProfileItem(
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        leading: SizedBox(
                          width: 24,
                          height: 24,
                          child: SvgPicture.asset(AppIcons.bookmarkFilled),
                        ),
                        trailing: const SizedBox(),
                        title: Text(
                          'Saqlanganlar',
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          Navigator.of(context).push(SavedScreen.route());
                        },
                        height: 56,
                      ),
                    ],
                  ),
                ),
                ProfileItem(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  leading: SizedBox(
                    width: 24,
                    height: 24,
                    child: SvgPicture.asset(AppIcons.logout),
                  ),
                  trailing: SvgPicture.asset(AppIcons.arrowForwardIos),
                  title: Text(
                    'Logout',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Akkountdan chiqish',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                            ),
                            WScaleAnimation(
                              onTap: () {
                                Navigator.pop(_);
                              },
                              child: SvgPicture.asset(AppIcons.closeGreen),
                            ),
                          ],
                        ),
                        content: Text(
                          'Haqiqatdan ham ilovadan chiqmoqchimisiz?',
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                        ),
                        actions: [
                          Row(
                            children: [
                              Expanded(
                                child: WButton(
                                  onTap: () {
                                    Navigator.pop(_);
                                  },
                                  text: 'Bekor qilish',
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: WButton(
                                  onTap: () {
                                    context
                                        .read<AuthenticationBloc>()
                                        .add(AuthenticationLogoutRequested(
                                          onSucces: () {
                                            Navigator.pop(_);
                                          },
                                          onError: (message) {
                                            Navigator.pop(_);
                                            showErrorSnackBar(context, message);
                                          },
                                        ));
                                  },
                                  text: 'Chiqish',
                                  color: red,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  height: 42,
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
                        .push(MaterialPageRoute(
                      builder: (_) => LoginScreen(
                          authenticationRepository:
                              RepositoryProvider.of<AuthenticationRepository>(
                                  context)),
                    ));
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
