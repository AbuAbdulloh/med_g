import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/widgets/w_scale_animation.dart';
import 'package:med_g/widgets/w_textfield.dart';

class SavedAppBar extends StatelessWidget {
  const SavedAppBar({
    required this.searchController,
    Key? key,
  }) : super(key: key);

  final TextEditingController searchController;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 2,
      toolbarHeight: 64,
      expandedHeight: MediaQuery.of(context).padding.top + 128,
      pinned: true,
      backgroundColor: white,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      centerTitle: false,
      title: Row(
        children: [
          WScaleAnimation(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SvgPicture.asset(AppIcons.arrowLeft),
            ),
          ),
          Text(
            'Saqlanganlar',
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      actions: [
        WScaleAnimation(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SvgPicture.asset(AppIcons.notifications),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Column(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: WTextField(
                controller: searchController,
                onChanged: (_) {},
                contentPadding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
                hintText: 'Saqlanganlar orasidan izlash',
                prefix: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: SvgPicture.asset(AppIcons.search),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
