import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/widgets/w_button.dart';

class WBackButton extends StatelessWidget {
  const WBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppTheme.black.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 1,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: WButton(
        padding: EdgeInsets.zero,
        color: AppTheme.white,
        onTap: () {
          Navigator.of(context).pop();
        },
        width: 31,
        height: 31,
        child: SvgPicture.asset(AppIcons.arrowBackIos),
      ),
    );
  }
}
