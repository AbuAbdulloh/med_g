// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return ChatMessage(
    body: json['body'] as String? ?? '',
    chatId: json['chat'] as int? ?? 0,
    createdAt: json['created_at'] as String? ?? '',
    edited: json['edited'] as bool? ?? false,
    id: json['id'] as int? ?? 0,
    seen: json['seen'] as bool? ?? false,
    senderId: json['sender'] as int? ?? 0,
  );
}

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender': instance.senderId,
      'chat': instance.chatId,
      'body': instance.body,
      'created_at': instance.createdAt,
      'edited': instance.edited,
      'seen': instance.seen,
    };
