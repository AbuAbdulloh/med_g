import 'package:flutter/material.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/screens/review_details/review_details.dart';
import 'package:med_g/widgets/w_like_button.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class ReviewItem extends StatelessWidget {
  final String name;
  final String time;
  final List<Widget> items;
  const ReviewItem({
    required this.name,
    required this.time,
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: (_) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ReviewDetails(
              name: name,
              time: time,
              items: items,
            ),
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: AppTheme.white,
          boxShadow: [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.normal,
                    color: AppTheme.black.withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 17,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          time,
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const WLikeButton(),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(18, 28, 18, 12),
              width: double.maxFinite,
              decoration: const BoxDecoration(
                  // color: AppTheme.white,
                  ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...items,
                  const SizedBox(height: 8),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
