// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMessage _$SendMessageFromJson(Map<String, dynamic> json) {
  return SendMessage(
    action: json['action'] as String? ?? '',
    data: json['data'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$SendMessageToJson(SendMessage instance) =>
    <String, dynamic>{
      'action': instance.action,
      'data': instance.data,
    };
