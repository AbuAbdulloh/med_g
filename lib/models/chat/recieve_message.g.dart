// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recieve_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecieveMessage _$RecieveMessageFromJson(Map<String, dynamic> json) {
  return RecieveMessage(
    action: json['action'] as String? ?? '',
    data: ChatMessage.fromJson(json['data'] as Map<String, dynamic>),
    type: json['type'] as String? ?? '',
    status: json['status'] as String? ?? '',
  );
}

Map<String, dynamic> _$RecieveMessageToJson(RecieveMessage instance) =>
    <String, dynamic>{
      'action': instance.action,
      'type': instance.type,
      'status': instance.status,
      'data': instance.data,
    };
