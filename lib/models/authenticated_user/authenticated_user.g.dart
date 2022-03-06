// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticated_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticatedUser _$AuthenticatedUserFromJson(Map<String, dynamic> json) =>
    AuthenticatedUser(
      address: json['address'] as String? ?? '',
      allergy: json['allergy'] as String? ?? '',
      birthDate: json['birthDate'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      height: json['height'] as int? ?? 0,
      hobby: json['hobby'] as String? ?? '',
      id: json['id'] as String? ?? '',
      image: json['image'] as String? ?? '',
      patronymic: json['patronymic'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      status: json['status'] as int? ?? 0,
      password: json['password'] as String? ?? '',
      surname: json['sur_name'] as String? ?? '',
      weight: json['weight'] as int? ?? 0,
    );

Map<String, dynamic> _$AuthenticatedUserToJson(AuthenticatedUser instance) =>
    <String, dynamic>{
      'address': instance.address,
      'allergy': instance.allergy,
      'birthDate': instance.birthDate,
      'firstName': instance.firstName,
      'height': instance.height,
      'hobby': instance.hobby,
      'id': instance.id,
      'image': instance.image,
      'password': instance.password,
      'patronymic': instance.patronymic,
      'phone': instance.phone,
      'status': instance.status,
      'sur_name': instance.surname,
      'weight': instance.weight,
    };
