import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/screens/article_single/article_single_screen.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      scaleValue: 0.98,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => const ArticleSingleScreen(),
        ));
      },
      child: Container(
        width: double.maxFinite,
        height: 200,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                color: black.withOpacity(0.25))
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kunlik badantarbiyaning foydalari',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Dr. Alisher Bahodirovich',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Kardiologiya',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  color: black,
                  width: 80,
                  height: 80,
                )
              ],
            ),
            Container(
              width: double.maxFinite,
              height: 1,
              color: stroke,
              margin: const EdgeInsets.only(top: 6, bottom: 8),
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur consequat ornare arcu, sit amet commodo velit iaculis ut. Donec enim.',
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  '12.04.2022y',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const Spacer(),
                SvgPicture.asset(AppIcons.bookmarkFilled)
              ],
            )
          ],
        ),
      ),
    );
  }
}
