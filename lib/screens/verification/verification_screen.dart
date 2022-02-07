import 'package:flutter/material.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/widgets/w_back_button.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:med_g/widgets/w_scale_animation.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => const VerificationScreen(),
      );

  const VerificationScreen({Key? key}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late TextEditingController pinCodeController;

  @override
  void initState() {
    super.initState();
    pinCodeController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    pinCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
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
                style: Theme.of(context)
                    .textTheme
                    .headline1!
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  PinCodeTextField(
                    controller: pinCodeController,
                    appContext: context,
                    length: 6,
                    keyboardType: TextInputType.number,
                    enableActiveFill: true,
                    cursorHeight: 20,
                    textStyle: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
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
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 16)),
                  const SizedBox(height: 8),
                  WScaleAnimation(
                    child: Text(
                      'Resend a new code',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: 16),
                    ),
                    onTap: (_) {},
                  ),
                ],
              ),
            ),
            WButton(
              onTap: () {},
              text: 'Continue',
            ),
          ],
        ),
      ),
    );
  }
}
