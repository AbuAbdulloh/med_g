// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatUser _$ChatUserFromJson(Map<String, dynamic> json) {
  return ChatUser(
    avatarUrl: json['avatar_url'] as String? ?? '',
    category: json['category'] == null
        ? null
        : CategoryResponse.fromJson(json['category'] as Map<String, dynamic>),
    id: json['id'] as int? ?? 0,
    name: json['name'] as String? ?? '',
    online: json['online'] as bool? ?? false,
  );
}

Map<String, dynamic> _$ChatUserToJson(ChatUser instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'category': instance.category,
      'online': instance.online,
    };
