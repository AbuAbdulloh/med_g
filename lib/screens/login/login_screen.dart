import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/screens/login/signup_screen.dart';
import 'package:med_g/screens/login/widgets/text_field_with_label.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:med_g/widgets/w_scale_animation.dart';
import 'package:med_g/widgets/w_textfield.dart';
import 'package:med_g/widgets/w_transparent_app_bar.dart';

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

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
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
    return KeyboardDismisser(
      child: Scaffold(
        appBar: WTransparentAppBar(mediaQuery: mediaQuery),
        body: Column(
          children: [
            Expanded(
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
                          hintText: 'Enter password...',
                          // isObscureText: isObscure,
                          keyBoardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          suffix: Container(
                            width: 40,
                            child: SvgPicture.asset(AppIcons.eyeOff),
                          ),
                          onEditCompleted: () {},
                          // obscureText: isObscure,
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
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                      onTap: (_) {},
                    ),
                    const SizedBox(height: 50),
                    WButton(
                      onTap: () {},
                      text: 'Sign In',
                      textStyle:
                          Theme.of(context).textTheme.headline2!.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Do not have account yet?',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            WButton(
              margin: const EdgeInsets.all(16),
              color: AppTheme.borderGrey,
              onTap: () {
                Navigator.of(context).push(SignupScreen.route());
              },
              text: 'Sign Up',
              textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(),
            )
          ],
        ),
      ),
    );
  }
}
