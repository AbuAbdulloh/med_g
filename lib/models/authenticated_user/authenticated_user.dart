import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authenticated_user.g.dart';

@JsonSerializable()
class AuthenticatedUser extends Equatable {
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'phone', defaultValue: '')
  final String phone;
  @JsonKey(name: 'first_name', defaultValue: '')
  final String firstName;
  @JsonKey(name: 'patronymic', defaultValue: '')
  final String patronymic;
  @JsonKey(name: 'allergy', defaultValue: '')
  final String allergy;
  @JsonKey(name: 'hobby', defaultValue: '')
  final String hobby;
  @JsonKey(name: 'image', defaultValue: '')
  final String image;
  @JsonKey(name: 'address', defaultValue: '')
  final String address;
  @JsonKey(name: 'height', defaultValue: 0)
  final int height;
  @JsonKey(name: 'weight', defaultValue: 0)
  final int weight;
  @JsonKey(name: 'status', defaultValue: 0)
  final int status;
  @JsonKey(name: 'birth_date', defaultValue: '')
  final String birthDate;

  const AuthenticatedUser({
    required this.address,
    required this.allergy,
    required this.birthDate,
    required this.firstName,
    required this.height,
    required this.hobby,
    required this.id,
    required this.image,
    required this.patronymic,
    required this.phone,
    required this.status,
    required this.weight,
  });

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) =>
      _$AuthenticatedUserFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticatedUserToJson(this);

  AuthenticatedUser copyWith({
    String? address,
    String? allergy,
    String? birthDate,
    String? firstName,
    int? height,
    String? hobby,
    String? id,
    String? image,
    String? password,
    String? patronymic,
    String? phone,
    int? status,
    String? surname,
    int? weight,
  }) =>
      AuthenticatedUser(
        address: address ?? this.address,
        allergy: allergy ?? this.allergy,
        birthDate: birthDate ?? this.birthDate,
        firstName: firstName ?? this.firstName,
        height: height ?? this.height,
        hobby: hobby ?? this.hobby,
        id: id ?? this.id,
        image: image ?? this.image,
        patronymic: patronymic ?? this.patronymic,
        phone: phone ?? this.phone,
        status: status ?? this.status,
        weight: weight ?? this.weight,
      );

  @override
  List<Object> get props => [
        address,
        allergy,
        birthDate,
        firstName,
        height,
        hobby,
        id,
        image,
        patronymic,
        phone,
        status,
        weight,
      ];


  @override
  String toString() {
    return 'AuthenticatedUser(id: $id, phone: $phone, firstName: $firstName, patronymic: $patronymic, allergy: $allergy, hobby: $hobby, image: $image, address: $address, height: $height, weight: $weight, status: $status, birthDate: $birthDate)';
  }
}
