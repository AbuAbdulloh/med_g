// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return Chat(
    id: json['id'] as int? ?? 0,
    messages: (json['messages'] as List<dynamic>?)
            ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    user: ChatUser.fromJson(json['user'] as Map<String, dynamic>),
    unreadMessages: json['nooo'] as int? ?? 0,
  );
}

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'nooo': instance.unreadMessages,
      'messages': instance.messages,
    };
