import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/bloc/bloc/authentication_bloc.dart';
import 'package:med_g/models/authentication_status/authentication_status.dart';
import 'package:med_g/models/register/register.dart';
import 'package:med_g/models/submission_status/submission_status.dart';
import 'package:med_g/screens/home/home.dart';
import 'package:med_g/screens/login/bloc/bloc/login_bloc.dart';
import 'package:med_g/widgets/w_back_button.dart';
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

  @override
  void initState() {
    super.initState();
    pinCodeController = TextEditingController();
    startCount();
  }

  @override
  void dispose() {
    pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context).textTheme;
    return BlocProvider.value(
      value: widget.bloc,
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: AppTheme.background,
          appBar: PreferredSize(
            child: Container(
              height: 55,
              margin: EdgeInsets.only(
                  top: mediaQuery.padding.top, left: 14, right: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const WBackButton(),
                  Text(
                    'Phone Verification',
                    style: theme.headline1!
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 24, width: 24)
                ],
              ),
            ),
            preferredSize: Size.fromHeight(mediaQuery.padding.top + 55),
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            color: AppTheme.background,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 26.5),
                      Text(
                        'Enter your OTP here',
                        style: theme.bodyText1!.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      PinCodeTextField(
                        autoFocus: true,
                        controller: pinCodeController,
                        appContext: context,
                        length: 6,
                        autoDisposeControllers: false,
                        keyboardType: TextInputType.number,
                        enableActiveFill: true,
                        cursorHeight: 20,
                        textStyle: theme.headline2!.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w500),
                        boxShadows: [
                          BoxShadow(
                              color: AppTheme.redAccent.withOpacity(0.3),
                              offset: const Offset(0, 5),
                              spreadRadius: 1,
                              blurRadius: 8)
                        ],
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.circle,
                            selectedFillColor: AppTheme.white,
                            activeFillColor: AppTheme.redAccent,
                            inactiveFillColor: AppTheme.white,
                            activeColor: AppTheme.redAccent,
                            inactiveColor: AppTheme.white),
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 25),
                      Text("Didn't you received any code?",
                          style: theme.bodyText1!.copyWith(fontSize: 16)),
                      const SizedBox(height: 8),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state.status ==
                              SubmissionStatus.submissionInProgress) {
                            return const Center(
                                child: CupertinoActivityIndicator());
                          }
                          return WScaleAnimation(
                            child: Text(
                              seconds != 0
                                  ? 'Tap to resend a new code: ${formatTime(seconds)}'
                                  : 'Resend a new code',
                              style: theme.headline5!.copyWith(fontSize: 16),
                            ),
                            onTap: (_) {
                              if (seconds == 0) {
                                FocusScope.of(context).unfocus();
                                widget.bloc.add(
                                  UserSignedUp(
                                      register: Register(
                                        firstName: state.register.firstName,
                                        password: state.register.password,
                                        phone: '998${state.register.phone}',
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
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return WButton(
                      loading:
                          state.status == SubmissionStatus.submissionInProgress,
                      disabled:
                          state.status == SubmissionStatus.submissionInProgress,
                      onTap: () {
                        context.read<LoginBloc>().add(
                              UserVerified(
                                  pinCode: pinCodeController.text.trim(),
                                  onSucces: () {
                                    context.read<AuthenticationBloc>().add(
                                        const AuthenticationStatusChanged(
                                            AuthenticationStatus
                                                .authenticated));
                                  },
                                  onError: (message) {
                                    showErrorSnackBar(context, message);
                                  }),
                            );
                      },
                      text: 'Continue',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startCount() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
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
