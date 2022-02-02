import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class WLikeButton extends StatelessWidget {
  const WLikeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: (_) {},
      child: Container(
        width: 42,
        height: 42,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppTheme.white.withOpacity(0.35),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.c1479FF.withOpacity(0.35),
              blurRadius: 35,
              spreadRadius: 0,
              offset: const Offset(0, 15),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
            color: AppTheme.white,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            AppIcons.heartRed,
          ),
        ),
      ),
    );
  }
}
