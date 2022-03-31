// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendBody _$SendBodyFromJson(Map<String, dynamic> json) {
  return SendBody(
    chatId: json['chat'] as int? ?? 0,
    message: json['body'] as String? ?? '',
  );
}

Map<String, dynamic> _$SendBodyToJson(SendBody instance) => <String, dynamic>{
      'chat': instance.chatId,
      'body': instance.message,
    };
