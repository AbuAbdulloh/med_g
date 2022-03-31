import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:med_g/models/chat/chat.dart';
import 'package:med_g/repository/chat.dart';
import 'package:med_g/screens/chatting_single/bloc/bloc.dart';
import 'package:med_g/screens/chatting_single/bloc/events.dart';
import 'package:med_g/screens/chatting_single/bloc/state.dart';
import 'package:med_g/screens/chatting_single/parts/appbar.dart';
import 'package:med_g/screens/chatting_single/parts/message_list.dart';
import 'package:med_g/screens/chatting_single/parts/typing_bar.dart';

class SingleChatScreen extends StatefulWidget {
  final Chat chat;

  const SingleChatScreen({Key? key, required this.chat}) : super(key: key);

  @override
  State<SingleChatScreen> createState() => _SingleChatScreenState();
}

class _SingleChatScreenState extends State<SingleChatScreen> {
  late ChatSingleBloc chatSingleBloc;
  late ChatRepository repository;

  @override
  void initState() {
    repository = ChatRepository()..transformSocket();

    chatSingleBloc = ChatSingleBloc(repository);
    if (widget.chat.id > 0) {
      chatSingleBloc.add(GetSingleChat(id: widget.chat.id));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: chatSingleBloc,
            ),
          ],
          child: Scaffold(
            appBar: SingleChatAppBar(chat: widget.chat),
            body: BlocListener<ChatSingleBloc, ChatSingleState>(
              listener: (context, state) {
                if (state.chatStatus == FormzStatus.valid) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                }
              },
              child: Column(
                children: [
                  MessageList(
                    userId: widget.chat.user.id,
                  ),
                  ChatTypingBar(
                      chatId: widget.chat.id, userId: widget.chat.user.id),
                  const SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
