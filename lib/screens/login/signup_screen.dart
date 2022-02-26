import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/models/register/register.dart';
import 'package:med_g/models/submission_status/submission_status.dart';
import 'package:med_g/screens/login/bloc/bloc/login_bloc.dart';
import 'package:med_g/screens/login/login_screen.dart';
import 'package:med_g/screens/login/widgets/text_field_with_label.dart';
import 'package:med_g/screens/verification/verification_screen.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:med_g/widgets/w_error_snack_bar.dart';
import 'package:med_g/widgets/w_scale_animation.dart';
import 'package:med_g/widgets/w_transparent_app_bar.dart';

class SignupScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => const SignupScreen(),
      );
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late LoginBloc loginBloc;
  bool isObscure = false;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();

    loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
    loginBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context).textTheme;
    return BlocProvider.value(
      value: loginBloc,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 16, right: 16),
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: mediaQuery.viewInsets.bottom == 0
                ? mediaQuery.size.height
                : null,
            child: Column(
              children: [
                const SizedBox(height: 55),
                Align(
                  child: Text(
                    'Create New Account',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(height: 6),
                Align(
                  child: Text(
                    'Enter Your details to create account',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                const SizedBox(height: 50),
                TextFieldWithLabel(
                  controller: nameController,
                  title: 'Name:',
                  hintText: 'Enter your name...',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {},
                  onEditDone: () {
                    FocusScope.of(context).nextFocus();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextFieldWithLabel(
                    prefix: Container(
                      alignment: Alignment.centerRight,
                      width: 40,
                      child: Text(
                        '+998 ',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
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
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
                        loginBloc.add(
                          UserSignedUp(
                              register: Register(
                                firstName: nameController.text.trim(),
                                password: passwordController.text.trim(),
                                phone:
                                    '998${phoneController.text.replaceAll('-', '').replaceAll('(', '').replaceAll(')', '').replaceAll(' ', '').trim()}',
                              ),
                              onSucces: () {
                                Navigator.of(context)
                                    .push(VerificationScreen.route(
                                  bloc: loginBloc,
                                ));
                              },
                              onError: (message) {
                                showErrorSnackBar(context, message);
                              }),
                        );
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
                            child: SvgPicture.asset(
                                isObscure ? AppIcons.eyeOff : AppIcons.eyeOn),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) => WButton(
                    loading:
                        state.status == SubmissionStatus.submissionInProgress,
                    disabled:
                        state.status == SubmissionStatus.submissionInProgress,
                    onTap: () {
                      context.read<LoginBloc>().add(
                            UserSignedUp(
                                register: Register(
                                  firstName: nameController.text.trim(),
                                  password: passwordController.text.trim(),
                                  phone:
                                      '998${phoneController.text.replaceAll('-', '').replaceAll('(', '').replaceAll(')', '').replaceAll(' ', '').trim()}',
                                ),
                                onSucces: () {
                                  Navigator.of(context)
                                      .push(VerificationScreen.route(
                                    bloc: loginBloc,
                                  ));
                                },
                                onError: (message) {
                                  showErrorSnackBar(context, message);
                                  Navigator.of(context)
                                      .push(VerificationScreen.route(
                                    bloc: loginBloc,
                                  ));
                                }),
                          );
                    },
                    text: 'Sign Up',
                    textStyle: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                if (mediaQuery.viewInsets.bottom == 0) ...{const Spacer()},
                Text(
                  'Already have Account?',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                WButton(
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                  color: AppTheme.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      color: AppTheme.black.withOpacity(0.25),
                    )
                  ],
                  child: Text(
                    'Sign In',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(LoginScreen.route());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
