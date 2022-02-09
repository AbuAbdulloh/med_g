import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/models/register/register.dart';
import 'package:med_g/models/submission_status/submission_status.dart';
import 'package:med_g/screens/home/home.dart';
import 'package:med_g/screens/login/bloc/bloc/login_bloc.dart';
import 'package:med_g/screens/login/login_screen.dart';
import 'package:med_g/screens/login/widgets/text_field_with_label.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:med_g/widgets/w_scale_animation.dart';
import 'package:med_g/widgets/w_textfield.dart';
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
    return BlocProvider.value(
      value: loginBloc,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: WTransparentAppBar(mediaQuery: mediaQuery),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 16, right: 16),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),
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
                          alignment: Alignment.center,
                          width: 40,
                          child: Text(
                            '+998',
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
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
                        hintText: '00 000-00-00',
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
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        WTextField(
                          controller: passwordController,
                          onChanged: (value) {},
                          fillColor: AppTheme.white,
                          borderRadius: 8,
                          hintText: 'Create password...',
                          isObscureText: isObscure,
                          keyBoardType: TextInputType.none,
                          textInputAction: TextInputAction.done,
                          suffix: SizedBox(
                            width: 40,
                            child: SvgPicture.asset(AppIcons.eyeOff),
                          ),
                          onEditCompleted: () {},
                          obscureText: isObscure,
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) => WButton(
                        loading: state.status ==
                            SubmissionStatus.submissionInProgress,
                        disabled: state.status ==
                            SubmissionStatus.submissionInProgress,
                        onTap: () {
                          context.read<LoginBloc>().add(
                                UserSignedUp(
                                    register: Register(
                                      firstName: nameController.text.trim(),
                                      password: passwordController.text.trim(),
                                      phone: phoneController.text.trim(),
                                    ),
                                    onSucces: () {
                                      Navigator.of(context)
                                          .push(HomeScreen.route());
                                    },
                                    onError: (message) {
                                      print(message);
                                    }),
                              );
                        },
                        text: 'Sign Up',
                        textStyle:
                            Theme.of(context).textTheme.headline2!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                children: [
                  WScaleAnimation(
                    child: Text(
                      'Already have Account?',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    onTap: (_) {},
                  ),
                  WButton(
                    margin: const EdgeInsets.only(top: 8),
                    color: const Color(0XFFDAE4F0),
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
          ],
        ),
      ),
    );
  }
}
