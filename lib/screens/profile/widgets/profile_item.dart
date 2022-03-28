import 'package:flutter/material.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/widgets/w_button.dart';

class ProfileItem extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget trailing;
  final Function() onTap;
  final double? width;
  final double height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  const ProfileItem({
    required this.leading,
    required this.trailing,
    required this.title,
    required this.onTap,
    required this.height,
    this.margin,
    this.padding,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WButton(
      width: width,
      borderRadius: 8,
      margin: margin,
      padding: padding ?? EdgeInsets.zero,
      color: white,
      onTap: onTap,
      height: height,
      boxShadow: [
        BoxShadow(
          offset: const Offset(2, 2),
          blurRadius: 10,
          color: black.withOpacity(0.25),
        ),
      ],
      child: Row(
        children: [
          leading,
          const SizedBox(width: 8),
          Expanded(
            child: title,
          ),
          const SizedBox(width: 8),
          trailing,
        ],
      ),
    );
  }
}
