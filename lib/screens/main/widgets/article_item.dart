import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/app_images.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/bloc/bloc/authentication_bloc.dart';
import 'package:med_g/models/article/article.dart';
import 'package:med_g/models/authentication_status/authentication_status.dart';
import 'package:med_g/screens/article_single/article_single_screen.dart';
import 'package:med_g/widgets/w_scale_animation.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleItem extends StatelessWidget {
  final Article article;
  const ArticleItem({
    required this.article,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      scaleValue: 0.98,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ArticleSingleScreen(article: article),
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
                        article.title,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        article.author,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        article.category.name,
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
                  clipBehavior: Clip.hardEdge,
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CachedNetworkImage(
                    width: 80,
                    height: 80,
                    imageUrl: article.thumbnail,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Shimmer.fromColors(
                      child: Container(
                        width: 80,
                        height: 80,
                        color: white,
                      ),
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      AppImages.errorPlaceholder,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.maxFinite,
              height: 1,
              color: stroke,
              margin: const EdgeInsets.only(top: 6, bottom: 8),
            ),
            Text(
              article.description,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  '${Jiffy(article.createdAt).format('dd.MM.yyyy')}y',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const Spacer(),
                if (context.read<AuthenticationBloc>().state.status ==
                    AuthenticationStatus.authenticated)
                  SvgPicture.asset(AppIcons.bookmarkFilled)
              ],
            )
          ],
        ),
      ),
    );
  }
}
