import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/app_images.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/widgets/w_scale_animation.dart';

class ArticleSingleScreen extends StatelessWidget {
  const ArticleSingleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (_, isExpanded) => [
        SliverAppBar(
          elevation: 2,
          shadowColor: black.withOpacity(0.25),
          pinned: true,
          toolbarHeight: 56,
          backgroundColor: white,
          titleSpacing: 0,
          expandedHeight: MediaQuery.of(context).padding.top + 238,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            expandedTitleScale: 1,
            titlePadding: EdgeInsets.zero,
            title: Padding(
              padding: const EdgeInsets.only(left: 50, bottom: 16),
              child: Text(
                'Kunlik badantarbiyaning foydalari',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            background: Image.asset(
              AppImages.doctor,
              fit: BoxFit.cover,
            ),
          ),
          leading: WScaleAnimation(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SvgPicture.asset(AppIcons.arrowLeft),
            ),
          ),
        )
      ],
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          height: 500,
          decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(12),
                right: Radius.circular(12),
              )),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kunlik badantarbiyaning foydalari',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
