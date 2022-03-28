import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/models/category/category.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class CategoryItem extends StatelessWidget {
  final CategoryResponse category;
  final VoidCallback onTap;
  const CategoryItem({
    required this.category,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            offset: const Offset(2, 2),
            blurRadius: 10,
            color: black.withOpacity(0.25),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 42,
            height: 42,
            child: SvgPicture.asset(AppIcons.psixalogiya),
          ),
          const Spacer(),
          Text(
            category.name,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 16),
          WScaleAnimation(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: primary, width: 1),
              ),
              child: Text(
                'Turkumga kirish',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
