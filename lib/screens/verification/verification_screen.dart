import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/bloc/bloc/authentication_bloc.dart';
import 'package:med_g/models/authentication_status/authentication_status.dart';
import 'package:med_g/models/register/register.dart';
import 'package:med_g/models/submission_status/submission_status.dart';
import 'package:med_g/screens/login/bloc/bloc/login_bloc.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:med_g/widgets/w_error_snack_bar.dart';
import 'package:med_g/widgets/w_scale_animation.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  final LoginBloc bloc;

  static Route route({required LoginBloc bloc}) => MaterialPageRoute(
        builder: (_) => VerificationScreen(bloc: bloc),
      );

  const VerificationScreen({
    required this.bloc,
    Key? key,
  }) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late TextEditingController pinCodeController;
  int seconds = 120;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    pinCodeController = TextEditingController();
    startCount();
  }

  @override
  void dispose() {
    pinCodeController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return KeyboardDismisser(
      child: BlocProvider.value(
        value: widget.bloc,
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
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 26.5),
                Text(
                  'Raqamni tasdiqlash',
                  style: theme.headline1!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  'Xush kelibsiz!',
                  style: theme.headline1!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Telefon raqamingizga yuborilgan SMS kodni kiritib raqamingizni tasdiqlang',
                  style: theme.headline3!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tasdiqlash kodi',
                      style: theme.headline1!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: WScaleAnimation(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Telefon raqamni o‘zgartirish',
                          style: theme.headline4!.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                PinCodeTextField(
                  autoFocus: true,
                  controller: pinCodeController,
                  appContext: context,
                  length: 6,
                  autoDisposeControllers: false,
                  keyboardType: TextInputType.number,
                  enableActiveFill: true,
                  cursorHeight: 20,
                  textStyle: theme.headline1!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                  pinTheme: PinTheme(
                    selectedFillColor: white,
                    activeFillColor: white,
                    inactiveFillColor: white,
                    activeColor: stroke,
                    inactiveColor: stroke,
                    errorBorderColor: red,
                    borderWidth: 1,
                    borderRadius: BorderRadius.circular(8),
                    selectedColor: primary,
                  ),
                  onChanged: (value) {},
                  onCompleted: (value) {
                    context.read<LoginBloc>().add(
                          UserVerified(
                              pinCode: pinCodeController.text.trim(),
                              onSucces: () {
                                context.read<AuthenticationBloc>().add(
                                    const AuthenticationStatusChanged(
                                        AuthenticationStatus.authenticated));
                              },
                              onError: (message) {
                                showErrorSnackBar(context, message);
                              }),
                        );
                  },
                ),
                const SizedBox(height: 12),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state.status == SubmissionStatus.submissionInProgress) {
                      return const Center(child: CupertinoActivityIndicator());
                    }
                    return WScaleAnimation(
                      isDisabled: seconds != 0,
                      child: Text(
                        seconds != 0
                            ? 'Kodni qayta yuborish: ${formatTime(seconds)}'
                            : 'Kodni qayta yuborish',
                        style: theme.headline4!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        if (seconds == 0) {
                          FocusScope.of(context).unfocus();
                          widget.bloc.add(
                            UserSignedUp(
                                register: Register(
                                  firstName: state.register.firstName,
                                  password: state.register.password,
                                  phone: state.register.phone,
                                ),
                                onSucces: () {
                                  setState(() {
                                    seconds = 120;
                                    startCount();
                                  });
                                },
                                onError: (message) {
                                  showErrorSnackBar(context, message);
                                }),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return WButton(
                height: 42,
                margin: const EdgeInsets.all(16),
                padding: EdgeInsets.zero,
                loading: state.status == SubmissionStatus.submissionInProgress,
                disabled: state.status == SubmissionStatus.submissionInProgress,
                onTap: () {
                  context.read<LoginBloc>().add(
                        UserVerified(
                            pinCode: pinCodeController.text.trim(),
                            onSucces: () {
                              context.read<AuthenticationBloc>().add(
                                  const AuthenticationStatusChanged(
                                      AuthenticationStatus.authenticated));
                            },
                            onError: (message) {
                              showErrorSnackBar(context, message);
                            }),
                      );
                },
                text: 'Ro’yxatdan o’tish',
              );
            },
          ),
        ),
      ),
    );
  }

  void startCount() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      this.timer = timer;
      if (seconds != 0) {
        seconds = seconds - 1;
        setState(() {});
      } else {
        timer.cancel();
      }
    });
  }

  String formatTime(int seconds) {
    if (seconds ~/ 60 == 2) {
      return '02:00';
    } else if (seconds ~/ 60 == 1) {
      return '01:${seconds - 60 >= 10 ? seconds - 60 : '0${seconds - 60}'}';
    } else {
      return '00:${seconds >= 10 ? seconds : '0$seconds'}';
    }
  }
}
