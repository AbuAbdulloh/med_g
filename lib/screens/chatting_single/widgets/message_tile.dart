import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/bloc/bloc/authentication_bloc.dart';
import 'package:med_g/models/chat/chat_message.dart';
import 'package:med_g/screens/chatting_single/bloc/bloc.dart';
import 'package:med_g/screens/chatting_single/bloc/events.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MessageTile extends StatelessWidget {
  final ChatMessage message;
  final int chatPartnerId;

  const MessageTile({
    required this.message,
    required this.chatPartnerId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMyMessage =
        message.senderId == context.read<AuthenticationBloc>().state.user.id;

    return VisibilityDetector(
      key: Key(message.id.toString()),
      onVisibilityChanged: (info) {
        final percentage = info.visibleFraction * 100;
        if (message.seen == false && percentage == 100 && !isMyMessage) {
          context
              .read<ChatSingleBloc>()
              .add(SeeMessageEvent(messageId: message.id));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment:
              isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: Container(
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                    color: isMyMessage
                        ? Theme.of(context).colorScheme.primary
                        : Color(0xffF9F9F9),
                    borderRadius: BorderRadius.circular(8)),
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                      child: Text(
                        message.body + '                         ',
                        style: isMyMessage
                            ? Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                )
                            : Theme.of(context).textTheme.headline1!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 6,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(12, 8, 6, 9),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: const Color(0xff66A1FF)),
                              ),
                              if (isMyMessage)
                                if (message.seen)
                                  SvgPicture.asset(
                                    AppIcons.calendar,
                                    width: 14,
                                    height: 14,
                                    color: Colors.white,
                                  )
                                else
                                  SvgPicture.asset(
                                    AppIcons.calendar,
                                    width: 14,
                                    height: 14,
                                    color: Colors.white,
                                  ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
