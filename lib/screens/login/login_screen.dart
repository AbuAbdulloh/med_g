import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/screens/login/widgets/text_field_with_label.dart';
import 'package:med_g/widgets/w_back_button.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class LoginScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      );
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;

  bool isObscure = false;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: mediaQuery.padding.top),
          child: Row(
            children: const [
              Padding(
                padding: EdgeInsets.all(16),
                child: WBackButton(),
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(mediaQuery.padding.top + 55),
      ),
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
                      controller: phoneController,
                      title: 'Phone number:',
                      hintText: 'Enter a phone number...',
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {},
                      onEditDone: () {
                        FocusScope.of(context).nextFocus();
                      },
                    ),
                  ),
                  TextFieldWithLabel(
                    controller: passwordController,
                    title: 'Password:',
                    hintText: 'Create password...',
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) {},
                    suffix: SizedBox(
                      width: 30,
                      child: SvgPicture.asset(AppIcons.eyeOff),
                    ),
                    isObscure: isObscure,
                    onSuffixTap: () {
                      print('tapped');
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                  ),
                  const SizedBox(height: 50),
                  WButton(
                    onTap: () {},
                    text: 'Sign Up',
                    textStyle: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
                  onTap: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
