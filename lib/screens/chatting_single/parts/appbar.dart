import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/models/chat/chat.dart';
import 'package:med_g/widgets/cached_image.dart';
import 'package:med_g/widgets/w_scale_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';


class SingleChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Chat chat;

  const SingleChatAppBar({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(
            16, 10 + MediaQuery.of(context).viewPadding.top, 16, 10),
        child: Row(
          children: [
            WScaleAnimation(
              onTap: () {
                Navigator.pop(context);
              },
              child: RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset(
                  AppIcons.arrowForwardIos,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Container(
              width: 38,
              height: 38,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey[300]!, width: 1)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedImage(
                          url: chat.user.avatarUrl, width: 36, height: 36,fit: BoxFit.contain,),
                    ),
                  ),

                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      chat.user.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    chat.user.category?.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            WScaleAnimation(
              onTap: () {
              },
              child: SvgPicture.asset(
                AppIcons.calendar,
                width: 24,
                height: 24,
              ),
            )
          ],
        ),
      );

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
