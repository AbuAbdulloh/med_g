
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:med_g/widgets/w_scale_animation.dart';
import 'package:med_g/widgets/w_textfield.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 2,
      toolbarHeight: 64,
      expandedHeight: MediaQuery.of(context).padding.top + 128,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: white,
      title: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: SvgPicture.asset(AppIcons.logoMain),
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
                hintText: 'Ilmiy maqolalarni izlash',
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
