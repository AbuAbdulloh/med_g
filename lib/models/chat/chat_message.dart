import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:med_g/models/pagination/iresult.dart';

part 'chat_message.g.dart';

@JsonSerializable()
class ChatMessage extends IResult with EquatableMixin{
  @JsonKey(name: 'id', defaultValue: 0)
  final int id;
  @JsonKey(name: 'sender', defaultValue: 0)
  final int senderId;
  @JsonKey(name: 'chat', defaultValue: 0)
  final int chatId;
  @JsonKey(name: 'body', defaultValue: '')
  final String body;
  @JsonKey(name: 'created_at', defaultValue: '')
  final String createdAt;
  @JsonKey(name: 'edited', defaultValue: false)
  final bool edited;
  @JsonKey(name: 'seen', defaultValue: false)
  final bool seen;
  const ChatMessage(
      {required this.body,
      required this.chatId,
      required this.createdAt,
      required this.edited,
      required this.id,
      required this.seen,
      required this.senderId});
  ChatMessage copyWith({bool? seen}) => ChatMessage(
      body: body,
      chatId: chatId,
      createdAt: createdAt,
      edited: edited,
      id: id,
      seen: seen ?? this.seen,
      senderId: senderId);

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

      @override
  List<Object?> get props =>[seen];
}
