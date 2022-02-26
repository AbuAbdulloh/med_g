import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/bloc/bloc/authentication_bloc.dart';
import 'package:med_g/models/authentication_status/authentication_status.dart';
import 'package:med_g/models/submission_status/submission_status.dart';
import 'package:med_g/screens/home/home.dart';
import 'package:med_g/screens/login/bloc/bloc/login_bloc.dart';
import 'package:med_g/screens/login/signup_screen.dart';
import 'package:med_g/screens/login/widgets/text_field_with_label.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:med_g/widgets/w_error_snack_bar.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

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
  bool isObscure = false;
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
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context).textTheme;
    return KeyboardDismisser(
      child: BlocProvider.value(
        value: bloc,
        child: Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: mediaQuery.viewInsets.bottom == 0
                  ? mediaQuery.size.height
                  : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 55),
                    SvgPicture.asset(AppIcons.logoColored),
                    const SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFieldWithLabel(
                        prefix: Container(
                          alignment: Alignment.centerRight,
                          width: 40,
                          child: Text(
                            ' +998 ',
                            style: theme.headline1!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        textInputFormatter: [
                          MaskTextInputFormatter(
                              mask: '(##) ###-##-##',
                              filter: {"#": RegExp(r'[0-9]')},
                              type: MaskAutoCompletionType.lazy),
                        ],
                        controller: phoneController,
                        title: 'Phone number:',
                        hintText: '(00) 000-00-00',
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {},
                        onEditDone: () {
                          FocusScope.of(context).nextFocus();
                        },
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Password',
                          style: theme.bodyText1!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          obscureText: isObscure,
                          controller: passwordController,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
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
                          },
                          onChanged: (_) {},
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                width: 1,
                                color: AppTheme.background,
                              ),
                            ),
                            hintText: 'Enter your password...',
                            hintStyle: theme.bodyText1!.copyWith(
                              fontSize: 16,
                            ),
                            filled: true,
                            fillColor: AppTheme.white,
                            contentPadding: const EdgeInsets.all(8),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                width: 1,
                                color: AppTheme.background,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                width: 1,
                                color: AppTheme.background,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                width: 1,
                                color: AppTheme.primary,
                              ),
                            ),
                            suffixIcon: WScaleAnimation(
                              onTap: (_) {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                child: SvgPicture.asset(isObscure
                                    ? AppIcons.eyeOff
                                    : AppIcons.eyeOn),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    WScaleAnimation(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 15),
                          Text(
                            'Forgot Password?',
                            style: theme.bodyText1!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      onTap: (_) {},
                    ),
                    const SizedBox(height: 34),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) => WButton(
                        loading: state.status ==
                            SubmissionStatus.submissionInProgress,
                        disabled: state.status ==
                            SubmissionStatus.submissionInProgress,
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
                    if (mediaQuery.viewInsets.bottom == 0) ...{const Spacer()},
                    Column(
                      children: [
                        Text(
                          'Do not have account yet?',
                          style: theme.headline1!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        WButton(
                          margin: const EdgeInsets.only(top: 16, bottom: 16),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                              color: AppTheme.black.withOpacity(0.25),
                            )
                          ],
                          color: AppTheme.white,
                          onTap: () {
                            Navigator.of(context).push(SignupScreen.route());
                          },
                          text: 'Sign Up',
                          textStyle: theme.bodyText1!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
