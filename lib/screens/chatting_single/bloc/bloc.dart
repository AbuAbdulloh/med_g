import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:med_g/models/chat/chat_message.dart';
import 'package:med_g/models/chat/recieve_message.dart';
import 'package:med_g/repository/chat.dart';
import 'package:med_g/screens/chatting_single/bloc/events.dart';
import 'package:med_g/screens/chatting_single/bloc/state.dart';


class ChatSingleBloc extends Bloc<ChatSingleEvents, ChatSingleState> {
  final ChatRepository repository;
  late StreamSubscription<dynamic> chatSubscription;

  ChatSingleBloc(this.repository)
      : super(const ChatSingleState(
            chatId: 0,
            chatStatus: FormzStatus.pure,
            paginationStatus: FormzStatus.pure,
            messages: [],
            status: FormzStatus.submissionSuccess,
            currentPage: 0,
            total: 0)) {
    chatSubscription = repository.messageStream.listen((recieveMessage) {
      print(recieveMessage);
      final json = RecieveMessage.fromJson(jsonDecode(recieveMessage));

      if (json.action == 'chat__create' && state.chatId == 0) {
        add(AddChatCreateEvent(chatId: json.data.id));
      } else if (json.action == 'message__create') {
        add(AddMessage(message: json));
      } else if (json.action == 'message__see') {
        add(AddSeenMessage(messageId: json.data.id));
      } else if (json.action == 'chat__delete') {
        if (state.chatId == json.data.id) {
          emit(state.copyWith(chatStatus: FormzStatus.valid));
          emit(state.copyWith(chatStatus: FormzStatus.pure));
        }
      }
    });

    on<GetSingleChat>((event, emit) async {
      try {
        emit(state.copyWith(
            status: FormzStatus.submissionInProgress, chatId: event.id));
        final result = await repository.getSinglChat(event.id);

        emit(state.copyWith(
          total: result.totalPages,
          status: FormzStatus.submissionSuccess,
          currentPage: result.currentPage,
          messages: result.results!.cast<ChatMessage>(),
        ));
      }on Exception catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    });
    on<GetMoreSingleMessages>((event, emit) {});

    on<AddMessage>((event, emit) {
      emit(state.copyWith(messages: [event.message.data, ...state.messages]));
    });
    on<SendMessageEvent>((event, emit) {
      repository.sendMessage(text: event.text, chatId: event.chatId);
    });
    on((event, emit) => null);
    on<AddSeenMessage>((event, emit) {
      var list = <ChatMessage>[...state.messages];
      var itemIndex = list
          .indexOf(list.firstWhere((element) => element.id == event.messageId));
      list[itemIndex] = list[itemIndex].copyWith(seen: true);
      emit(state.copyWith(messages: list));
    });

    on<SeeMessageEvent>((event, emit) {
      repository.seeMessage(id: event.messageId);
    });

    on<AddChatCreateEvent>((event, emit) {
      emit(state.copyWith(
          chatId: event.chatId, chatStatus: FormzStatus.submissionSuccess));
      emit(state.copyWith(chatStatus: FormzStatus.pure));
    });
    on<CreateChatEvent>((event, emit) {
      repository.createChat(userId: event.userId);
    });

    on<DeleteChat>((event, emit) {
      repository.deleteChat(chatId: event.chatId);
    });
  }

  @override
  Future<void> close() {
    chatSubscription.cancel();
    return super.close();
  }
}
