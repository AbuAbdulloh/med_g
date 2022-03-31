import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/screens/chatting_single/bloc/bloc.dart';
import 'package:med_g/screens/chatting_single/bloc/events.dart';
import 'package:med_g/screens/chatting_single/bloc/state.dart';
import 'package:med_g/widgets/w_textfield.dart';


class ChatTypingBar extends StatelessWidget {
  final int chatId;
  final int userId;

  ChatTypingBar({Key? key, required this.chatId, required this.userId})
      : super(key: key);
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: WTextField(
                hasBorderColor: false,
                keyBoardType: TextInputType.multiline,
                maxlines: null,
                contentPadding: const EdgeInsets.fromLTRB(16, 12, 40, 12),
                suffix: SvgPicture.asset(
                  AppIcons.edit,
                  width: 20,
                  height: 20,
                ),
                hintText: 'Напишите ваше сообщение',
                hintTextStyle: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff8C97AB).withOpacity(0.7)),
                borderRadius: 28,
                controller: textEditingController,
                onChanged: (s) {}),
          ),
          const SizedBox(
            width: 8,
          ),
          BlocConsumer<ChatSingleBloc, ChatSingleState>(
            listener: (context, state) {
              if (state.chatStatus == FormzStatus.submissionSuccess) {

                context.read<ChatSingleBloc>().add(SendMessageEvent(
                    chatId: state.chatId, text: textEditingController.text));
                textEditingController.clear();

              }
            },
            builder: (context, state) => GestureDetector(
              onTap: () {
                if (textEditingController.text.isNotEmpty) {
                  if (state.chatId > 0) {
                    context.read<ChatSingleBloc>().add(SendMessageEvent(
                        chatId: state.chatId, text: textEditingController.text));
                    textEditingController.clear();
                  } else {
                    context
                        .read<ChatSingleBloc>()
                        .add(CreateChatEvent(userId: userId));
                  }


                }
              },
              child: SvgPicture.asset(
                AppIcons.arrowForwardIos,
                width: 28,
                height: 28,
              ),
            ),
          )
        ],
      ));
}
