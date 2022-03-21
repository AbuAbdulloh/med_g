import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/models/register/register.dart';
import 'package:med_g/models/submission_status/submission_status.dart';
import 'package:med_g/screens/login/bloc/bloc/login_bloc.dart';
import 'package:med_g/screens/verification/verification_screen.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:med_g/widgets/w_error_snack_bar.dart';
import 'package:med_g/widgets/w_scale_animation.dart';
import 'package:med_g/widgets/w_textfield.dart';

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
    return KeyboardDismisser(
      child: BlocProvider.value(
        value: loginBloc,
        child: Scaffold(
          backgroundColor: background,
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
            padding: const EdgeInsets.only(left: 16, right: 16, top: 28),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Align(
                  child: Text(
                    'Ro’yxatdan o’tish',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                const SizedBox(height: 28),
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
                const SizedBox(height: 12),
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
                const SizedBox(height: 20),
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
                    text: 'Davom etish',
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
              WButton(
                margin: const EdgeInsets.all(16),
                color: white,
                border: Border.all(width: 1, color: stroke),
                onTap: () {
                  Navigator.pop(context);
                },
                text: 'Kirish',
                textStyle: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
