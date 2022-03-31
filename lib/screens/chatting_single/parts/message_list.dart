
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:med_g/screens/chatting_single/bloc/bloc.dart';
import 'package:med_g/screens/chatting_single/bloc/state.dart';
import 'package:med_g/screens/chatting_single/widgets/message_tile.dart';


class MessageList extends StatefulWidget {
  final int userId;

  const MessageList({Key? key, required this.userId}) : super(key: key);

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  // late AudioCache _audioCache;

  @override
  void initState() {
    // _audioCache = AudioCache(
    //     prefix: 'assets/audio/',
    //     fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Expanded(
        child: BlocConsumer<ChatSingleBloc, ChatSingleState>(
          listener: (context, state) {
            // _audioCache.play('tick.mp3');
          },
          listenWhen: (stat1, state2) {
            if (stat1.status == FormzStatus.submissionInProgress &&
                state2.status.isSubmissionSuccess) {
              return false;
            } else if (state2.messages.length > stat1.messages.length) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            if (state.status == FormzStatus.submissionSuccess) {
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) => MessageTile(
                        chatPartnerId: widget.userId,
                        message: state.messages[index],
                      ));
            } else if (state.status == FormzStatus.submissionInProgress) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      );
}
