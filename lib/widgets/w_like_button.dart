import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class WLikeButton extends StatelessWidget {
  const WLikeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: () {},
      child: Container(
        width: 42,
        height: 42,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: white.withOpacity(0.35),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: primary.withOpacity(0.35),
              blurRadius: 35,
              spreadRadius: 0,
              offset: const Offset(0, 15),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
            color: white,
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
