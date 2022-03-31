// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticated_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticatedUser _$AuthenticatedUserFromJson(Map<String, dynamic> json) =>
    AuthenticatedUser(
      address: json['address'] as String? ?? '',
      allergy: json['allergy'] as String? ?? '',
      birthDate: json['birth_date'] as String? ?? '',
      firstName: json['first_name'] as String? ?? '',
      height: (json['height'] as num?)?.toDouble() ?? 0,
      hobby: json['hobby'] as String? ?? '',
      id: json['id'] as String? ?? '',
      image: json['image'] as String? ?? '',
      patronymic: json['patronymic'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      status: json['status'] as int? ?? 0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$AuthenticatedUserToJson(AuthenticatedUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'first_name': instance.firstName,
      'patronymic': instance.patronymic,
      'allergy': instance.allergy,
      'hobby': instance.hobby,
      'image': instance.image,
      'address': instance.address,
      'height': instance.height,
      'weight': instance.weight,
      'status': instance.status,
      'birth_date': instance.birthDate,
    };
