import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authenticated_user.g.dart';

@JsonSerializable()
class AuthenticatedUser extends Equatable {
  @JsonKey(name: 'activatedAt', defaultValue: '')
  final String activatedAt;
  @JsonKey(name: 'address', defaultValue: '')
  final String address;
  @JsonKey(name: 'allergy', defaultValue: '')
  final String allergy;
  @JsonKey(name: 'birthDate', defaultValue: '')
  final String birthDate;
  @JsonKey(name: 'createdAt', defaultValue: '')
  final String createdAt;
  @JsonKey(name: 'firstName', defaultValue: '')
  final String firstName;
  @JsonKey(name: 'height', defaultValue: 0)
  final int height;
  @JsonKey(name: 'hobby', defaultValue: '')
  final String hobby;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'image', defaultValue: '')
  final String image;
  @JsonKey(name: 'password', defaultValue: '')
  final String password;
  @JsonKey(name: 'patronymic', defaultValue: '')
  final String patronymic;
  @JsonKey(name: 'phone', defaultValue: '')
  final String phone;
  @JsonKey(name: 'status', defaultValue: 0)
  final int status;
  @JsonKey(name: 'surname', defaultValue: '')
  final String surname;
  @JsonKey(name: 'updatedAt', defaultValue: '')
  final String updatedAt;
  @JsonKey(name: 'weight', defaultValue: 0)
  final int weight;

  const AuthenticatedUser({
    required this.activatedAt,
    required this.address,
    required this.allergy,
    required this.birthDate,
    required this.createdAt,
    required this.firstName,
    required this.height,
    required this.hobby,
    required this.id,
    required this.image,
    required this.password,
    required this.patronymic,
    required this.phone,
    required this.status,
    required this.surname,
    required this.updatedAt,
    required this.weight,
  });

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) =>
      _$AuthenticatedUserFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticatedUserToJson(this);

  AuthenticatedUser copyWith({
    String? activatedAt,
    String? address,
    String? allergy,
    String? birthDate,
    String? createdAt,
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
    String? updatedAt,
    int? weight,
  }) =>
      AuthenticatedUser(
        activatedAt: activatedAt ?? this.activatedAt,
        address: address ?? this.address,
        allergy: allergy ?? this.allergy,
        birthDate: birthDate ?? this.birthDate,
        createdAt: createdAt ?? this.createdAt,
        firstName: firstName ?? this.firstName,
        height: height ?? this.height,
        hobby: hobby ?? this.hobby,
        id: id ?? this.id,
        image: image ?? this.image,
        password: password ?? this.password,
        patronymic: patronymic ?? this.patronymic,
        phone: phone ?? this.phone,
        status: status ?? this.status,
        surname: surname ?? this.surname,
        updatedAt: updatedAt ?? this.updatedAt,
        weight: weight ?? this.weight,
      );

  @override
  List<Object> get props => [
        activatedAt,
        address,
        allergy,
        birthDate,
        createdAt,
        firstName,
        height,
        hobby,
        id,
        image,
        password,
        patronymic,
        phone,
        status,
        surname,
        updatedAt,
        weight,
      ];
  @override
  String toString() =>
      'AuthenticatedUser(activatedAt: $activatedAt, address: $address, allergy: $allergy, birthDate: $birthDate, createdAt: $createdAt, firstName: $firstName, height: $height, hobby: $hobby, id: $id, image: $image, password: $password, patronymic: $patronymic, phone: $phone, status: $status, surname: $surname, updatedAt: $updatedAt, weight: $weight)';
}
