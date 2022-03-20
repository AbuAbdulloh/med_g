import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/models/register/register.dart';
import 'package:med_g/models/submission_status/submission_status.dart';
import 'package:med_g/screens/login/bloc/bloc/login_bloc.dart';
import 'package:med_g/screens/login/login_screen.dart';
import 'package:med_g/screens/verification/verification_screen.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:med_g/widgets/w_error_snack_bar.dart';
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
    return BlocProvider.value(
      value: loginBloc,
      child: Scaffold(
        backgroundColor: background,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 16, right: 16),
          physics: const BouncingScrollPhysics(),
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
              WTextField(
                fillColor: white,
                controller: nameController,
                title: 'To`liq ism:',
                hintText: 'To`liq ismingizni kiriting...',
                keyBoardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                onChanged: (value) {},
                maxLength: 70,
                onEditCompleted: () {
                  FocusScope.of(context).nextFocus();
                },
              ),
              const SizedBox(height: 16),
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
                    loginBloc.add(
                      UserSignedUp(
                          register: Register(
                            firstName: nameController.text.trim(),
                            password: passwordController.text.trim(),
                            phone:
                                '998${phoneController.text.replaceAll(' ', '').trim()}',
                          ),
                          onSucces: () {
                            Navigator.of(context).push(VerificationScreen.route(
                              bloc: loginBloc,
                            ));
                          },
                          onError: (message) {
                            showErrorSnackBar(context, message);
                          }),
                    );
                  }),
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
                                    '998${phoneController.text.replaceAll(' ', '').trim()}',
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
                  text: 'Sign Up',
                  textStyle: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Already have Account?',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            WButton(
              margin: const EdgeInsets.all(16),
              text: 'Sign In',
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
