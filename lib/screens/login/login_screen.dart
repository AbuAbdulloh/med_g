import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/bloc/bloc/authentication_bloc.dart';
import 'package:med_g/models/authentication_status/authentication_status.dart';
import 'package:med_g/models/submission_status/submission_status.dart';
import 'package:med_g/screens/home/home.dart';
import 'package:med_g/screens/login/bloc/bloc/login_bloc.dart';
import 'package:med_g/screens/login/signup_screen.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:med_g/widgets/w_error_snack_bar.dart';
import 'package:med_g/widgets/w_scale_animation.dart';
import 'package:med_g/widgets/w_textfield.dart';

class LoginScreen extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const LoginScreen());
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late LoginBloc bloc;
  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    bloc = LoginBloc();
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return KeyboardDismisser(
      child: BlocProvider.value(
        value: bloc,
        child: Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 55),
                  SvgPicture.asset(AppIcons.logoColored),
                  const SizedBox(height: 60),
                  WTextField(
                      title: 'Telefon raqami',
                      fillColor: white,
                      prefixText: '+998',
                      hintText: '00 000 00 00',
                      textInputFormatters: [
                        MaskTextInputFormatter(
                          mask: '## ### ## ##',
                          filter: {'#': RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.lazy,
                        ),
                      ],
                      contentPadding: const EdgeInsets.fromLTRB(48, 12, 12, 12),
                      controller: phoneController,
                      onChanged: (_) {},
                      onEditCompleted: () {
                        FocusScope.of(context).nextFocus();
                      }),
                  const SizedBox(height: 16),
                  WTextField(
                      title: 'Maxfiylik kaliti',
                      fillColor: white,
                      hintText: 'Maxfiylik kalitini kiriting...',
                      keyBoardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      onChanged: (_) {},
                      isObscureText: true,
                      onEditCompleted: () {
                        FocusScope.of(context).unfocus();
                        bloc.add(UserLoggedIn(
                          phone: phoneController.text,
                          password: passwordController.text.trim(),
                          onSucces: () {
                            context.read<AuthenticationBloc>().add(
                                const AuthenticationStatusChanged(
                                    AuthenticationStatus.authenticated));
                          },
                          onError: (message) {
                            showErrorSnackBar(context, message);
                          },
                        ));
                      }),
                  const SizedBox(height: 16),
                  WScaleAnimation(
                    scaleValue: 0.95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 15),
                        Text(
                          'Maxfiylik kalitini unutdingizmi?',
                          style: theme.bodyText1!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(height: 34),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) => WButton(
                      loading:
                          state.status == SubmissionStatus.submissionInProgress,
                      disabled:
                          state.status == SubmissionStatus.submissionInProgress,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      onTap: () {
                        context.read<LoginBloc>().add(UserLoggedIn(
                              phone: phoneController.text,
                              password: passwordController.text.trim(),
                              onSucces: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  HomeScreen.route(),
                                  (route) => false,
                                );
                              },
                              onError: (message) {
                                showErrorSnackBar(context, message);
                              },
                            ));
                      },
                      text: 'Sign In',
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
          bottomNavigationBar: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Ilovadan ro`yxatdan o`tmaganmisiz?',
                style: theme.headline1!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              WButton(
                margin: const EdgeInsets.all(16),
                onTap: () {
                  Navigator.of(context).push(SignupScreen.route());
                },
                text: 'Sign Up',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
