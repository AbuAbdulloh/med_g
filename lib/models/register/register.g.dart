// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Register _$RegisterFromJson(Map<String, dynamic> json) => Register(
      firstName: json['first_name'] as String? ?? '',
      password: json['password'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
    );

Map<String, dynamic> _$RegisterToJson(Register instance) => <String, dynamic>{
      'first_name': instance.firstName,
      'password': instance.password,
      'phone': instance.phone,
    };
