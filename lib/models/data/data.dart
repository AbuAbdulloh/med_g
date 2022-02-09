import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  @JsonKey(name: 'sign_id', defaultValue: '')
  final String signIn;
  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;

  Data({
    required this.signIn,
    required this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
