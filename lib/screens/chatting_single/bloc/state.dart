import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:med_g/models/chat/chat_message.dart';

class ChatSingleState extends Equatable {
  final FormzStatus status;
  final FormzStatus paginationStatus;
  final List<ChatMessage> messages;
  final int total;
  final int currentPage;
  final int chatId;
  final FormzStatus chatStatus ;

 const ChatSingleState(
      {required this.messages,
      required this.chatId,
        required this.chatStatus,
      required this.status,
      required this.paginationStatus,
      required this.currentPage,
      required this.total});

  ChatSingleState copyWith({
    FormzStatus? status,
    FormzStatus? chatStatus ,
    int? chatId,
    FormzStatus? paginationStatus,
    List<ChatMessage>? messages,
    int? total,
    int? currentPage,
  }) =>
      ChatSingleState(chatStatus: chatStatus??this.chatStatus,
          paginationStatus: paginationStatus ?? this.paginationStatus,
          chatId: chatId ?? this.chatId,
          messages: messages ?? this.messages,
          status: status ?? this.status,
          currentPage: currentPage ?? this.currentPage,
          total: total ?? this.total);

  @override
  List<Object?> get props =>
      [status, messages, total, currentPage, paginationStatus,chatId,chatStatus];
}
