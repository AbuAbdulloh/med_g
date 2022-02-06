import 'package:flutter/material.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/widgets/w_textfield.dart';

class TextFieldWithLabel extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String? hintText;
  final Widget? suffix;
  final Function()? onSuffixTap;
  final bool isObscure;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function()? onEditDone;
  final Function(String message) onChanged;
  const TextFieldWithLabel({
    required this.controller,
    required this.title,
    required this.onChanged,
    this.isObscure = false,
    this.textInputAction,
    this.onEditDone,
    this.hintText,
    this.suffix,
    this.onSuffixTap,
    this.keyboardType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        WTextField(
          controller: controller,
          onChanged: onChanged,
          fillColor: AppTheme.white,
          borderRadius: 8,
          hintText: hintText,
          isObscureText: isObscure,
          keyBoardType: keyboardType,
          textInputAction: textInputAction ?? TextInputAction.done,
          suffix: suffix,
          onTapSuffix: onSuffixTap,
          onEditCompleted: onEditDone,
          obscureText: isObscure,
          obscure: isObscure,
        ),
      ],
    );
  }
}
