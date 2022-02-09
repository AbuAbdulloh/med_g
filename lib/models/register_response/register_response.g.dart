// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      errorCode: json['error_code'] as int? ?? 0,
      errorNote: json['error_note'] as String? ?? ' ',
      status: json['status'] as String? ?? ' ',
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'error_code': instance.errorCode,
      'error_note': instance.errorNote,
      'status': instance.status,
    };
