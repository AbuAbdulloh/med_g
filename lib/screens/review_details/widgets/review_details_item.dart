import 'package:flutter/material.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/widgets/w_like_button.dart';

class ReviewDetailsItem extends StatelessWidget {
  final String name;
  final String time;
  final List<Widget> items;
  const ReviewDetailsItem({
    required this.name,
    required this.time,
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: white,
        boxShadow: [],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  blurStyle: BlurStyle.normal,
                  color: black.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 62,
                  height: 62,
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        blurStyle: BlurStyle.normal,
                        color: black.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 17, bottom: 17),
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
                ),
                const WLikeButton(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(18, 28, 18, 12),
            width: double.maxFinite,
            decoration: const BoxDecoration(
                // color: white,
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
    );
  }
}
