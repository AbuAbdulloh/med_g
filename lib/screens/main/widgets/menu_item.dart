import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class MenuItem extends StatelessWidget {
  final String icon;
  final String title;
  final bool isActive;
  final Function() onTap;
  const MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isActive = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: (value) {
        onTap();
      },
      child: Container(
        width: 105,
        height: 100,
        decoration: BoxDecoration(
            color: isActive ? AppTheme.c1479FF : AppTheme.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: AppTheme.c82A3CA,
                blurRadius: 20,
                offset: Offset(0, 15),
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon),
            const SizedBox(height: 7),
            Text(
              title,
              style: isActive
                  ? Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      )
                  : Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
            )
          ],
        ),
      ),
    );
  }
}
