import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/models/navbar/nav_bar.dart';

class TabItemWidget extends StatelessWidget {
  final bool isActive;
  final NavBar item;

  const TabItemWidget({
    Key? key,
    this.isActive = false,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 51,
              height: 51,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? AppTheme.c1479FF : null,
              ),
              child: SvgPicture.asset(
                item.iconOn,
                fit: BoxFit.contain,
                color: isActive ? AppTheme.white : AppTheme.c516E95,
              ),
            ),
          ],
        ),
      );
}
