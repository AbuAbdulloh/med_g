import 'package:flutter/material.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/app/theme/theme.dart';

class SupprotDetailItem extends StatelessWidget {
  final String title;
  final List<Widget> items;
  const SupprotDetailItem({
    required this.title,
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: background,
        boxShadow: [
          // BoxShadow(
          //   color: AppTheme.black.withOpacity(0.7),
          //   blurRadius: 1,
          //   offset: const Offset(0, 1),
          // ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              boxShadow: [
                // BoxShadow(
                //   color: AppTheme.black.withOpacity(0.3),
                //   blurRadius: 1,
                //   blurStyle: BlurStyle.normal,
                //   offset: const Offset(0, 3),
                // )
              ],
            ),
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 17,
                  ),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 3),
            padding: const EdgeInsets.fromLTRB(18, 28, 18, 12),
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...items,
              ],
            ),
          )
        ],
      ),
    );
  }
}
