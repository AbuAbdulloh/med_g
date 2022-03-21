import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/colors.dart';
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
            SvgPicture.asset(
              item.iconOn,
              fit: BoxFit.contain,
              color: isActive ? dark : grey,
            ),
            const SizedBox(height: 4),
            Text(
              item.title,
              style: isActive
                  ? Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      )
                  : Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
            ),
          ],
        ),
      );
}
