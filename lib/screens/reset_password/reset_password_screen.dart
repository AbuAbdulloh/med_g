import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/generated/locale_keys.g.dart';
import 'package:med_g/repository/authentication.dart';
import 'package:med_g/screens/reset_password/bloc/reset_password_bloc.dart';
import 'package:med_g/screens/reset_password/parts/reset_verification.dart';
import 'package:med_g/screens/verification/verification_screen.dart';
import 'package:med_g/widgets/w_button.dart';
import 'package:med_g/widgets/w_error_snack_bar.dart';
import 'package:med_g/widgets/w_scale_animation.dart';
import 'package:med_g/widgets/w_textfield.dart';

class ResetPasswordScreen extends StatefulWidget {
  final AuthenticationRepository repository;
  const ResetPasswordScreen({
    required this.repository,
    Key? key,
  }) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController phoneController;
  late ResetPasswordBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ResetPasswordBloc(repository: widget.repository);
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: KeyboardDismisser(
        child: Scaffold(
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
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
              child: Column(
                children: [
                  Text(
                    'Raqamni kiritish',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 34),
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
                      FocusScope.of(context).unfocus();
                    },
                    keyBoardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar:
              BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
            builder: (context, state) {
              return WButton(
                margin: EdgeInsets.fromLTRB(
                    16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
                padding: EdgeInsets.zero,
                height: 42,
                loading: state.status == FormzStatus.submissionInProgress,
                onTap: () {
                  bloc.add(SendPhone(
                    phone: phoneController.text.replaceAll(' ', ''),
                    onSucces: () {
                      Navigator.of(context).push(ResetVerification.route(
                        bloc: bloc,
                      ));
                    },
                    onError: (message) {
                      showErrorSnackBar(context, message);
                    },
                  ));
                },
                text: LocaleKeys.continueing,
              );
            },
          ),
        ),
      ),
    );
  }
}
