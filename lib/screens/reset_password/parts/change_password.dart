import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/models/submission_status/submission_status.dart';
import 'package:med_g/screens/login/login_screen.dart';
import 'package:med_g/screens/reset_password/bloc/reset_password_bloc.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:med_g/widgets/w_error_snack_bar.dart';
import 'package:med_g/widgets/w_scale_animation.dart';
import 'package:med_g/widgets/w_textfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  final ResetPasswordBloc bloc;
  const ChangePasswordScreen({required this.bloc, Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController newPasswordController;
  late TextEditingController confirmNewPasswordController;

  @override
  void initState() {
    super.initState();
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return KeyboardDismisser(
      child: BlocProvider.value(
        value: widget.bloc,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(100 + MediaQuery.of(context).padding.top),
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              decoration: BoxDecoration(color: white, boxShadow: [
                BoxShadow(
                  color: black.withOpacity(0.16),
                  blurRadius: 16,
                )
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WScaleAnimation(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SvgPicture.asset(AppIcons.arrowLeft),
                    ),
                  ),
                  Align(child: SvgPicture.asset(AppIcons.logoMain)),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: SizedBox(width: 24),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
              child: Column(
                children: [
                  Text(
                    'Maxfiylik kalitini yaratish',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 34),
                  WTextField(
                    title: 'Maxfiylik kalitini o’rnating',
                    fillColor: white,
                    hintText: 'Maxfiylik kalitini o’rnatish',
                    keyBoardType: TextInputType.visiblePassword,
                    controller: newPasswordController,
                    onChanged: (_) {},
                    isObscureText: true,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  WTextField(
                    title: 'Maxfiylik kalitini tasdiqlang',
                    fillColor: white,
                    hintText: 'Maxfiylik kalitini tasdiqlash',
                    keyBoardType: TextInputType.visiblePassword,
                    controller: confirmNewPasswordController,
                    onChanged: (_) {},
                    isObscureText: true,
                    onEditCompleted: () {
                      FocusScope.of(context).unfocus();
                    },
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                builder: (context, state) => WButton(
                  loading:
                      state.status == SubmissionStatus.submissionInProgress,
                  disabled:
                      state.status == SubmissionStatus.submissionInProgress,
                  margin:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  onTap: () {
                    widget.bloc.add(ChangePassword(
                      newPassword: newPasswordController.text.trim(),
                      confirmNewPassword:
                          confirmNewPasswordController.text.trim(),
                      onSucces: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (_) => LoginScreen(
                                    authenticationRepository:
                                        widget.bloc.state.repository,
                                  )),
                          (route) => false,
                        );
                      },
                      onError: (message) {
                        showErrorSnackBar(context, message);
                      },
                    ));
                  },
                  text: 'Tasdiqlash',
                  textStyle: theme.headline2!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
