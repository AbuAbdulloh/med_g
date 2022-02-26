import 'package:json_annotation/json_annotation.dart';

part 'register.g.dart';

@JsonSerializable()
class Register {
  @JsonKey(name: 'first_name', defaultValue: '')
  final String firstName;
  @JsonKey(name: 'password', defaultValue: '')
  final String password;
  @JsonKey(name: 'phone', defaultValue: '')
  final String phone;

  Register({
    required this.firstName,
    required this.password,
    required this.phone,
  });

  factory Register.fromJson(Map<String, dynamic> json) =>
      _$RegisterFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterToJson(this);

  @override
  String toString() =>
      'Register(firstName: $firstName, password: $password, phone: $phone)';
}
