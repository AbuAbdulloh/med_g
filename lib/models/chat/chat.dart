import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:med_g/models/chat/chat_message.dart';
import 'package:med_g/models/chat/chat_user.dart';
import 'package:med_g/models/pagination/iresult.dart';

part 'chat.g.dart';


@JsonSerializable()
class Chat extends IResult with EquatableMixin {
  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'user')
  final ChatUser user;

  @JsonKey(name: 'nooo', defaultValue: 0)
  final int unreadMessages;

  @JsonKey(name: 'messages', defaultValue: [])
  final List<ChatMessage> messages;

  Chat(
      {required this.id,
      required this.messages,
      required this.user,
      required this.unreadMessages});

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Chat copyWith(
          {List<ChatMessage>? messages, int? unreadMessages, ChatUser? user}) =>
      Chat(
          id: id,
          messages: messages ?? this.messages,
          user: user ?? this.user,
          unreadMessages: unreadMessages ?? this.unreadMessages);

  @override
  List<Object?> get props => [messages, unreadMessages, user, id];
}
