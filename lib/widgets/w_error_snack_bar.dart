import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    padding: const EdgeInsets.all(12),
    onVisible: () {
      Timer(
        const Duration(seconds: 3),
        () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      );
    },
    content: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                message,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ),
          WScaleAnimation(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(AppIcons.closeGreen),
            ),
          ),
        ],
      ),
    ),
  ));
}
