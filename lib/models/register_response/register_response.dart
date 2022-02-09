import 'package:json_annotation/json_annotation.dart';

import 'package:med_g/models/data/data.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  @JsonKey(name: 'data')
  final Data? data;
  @JsonKey(name: 'error_code', defaultValue: 0)
  final int errorCode;
  @JsonKey(name: 'error_note', defaultValue: ' ')
  final String errorNote;
  @JsonKey(name: 'status', defaultValue: ' ')
  final String status;

  RegisterResponse({
    required this.data,
    required this.errorCode,
    required this.errorNote,
    required this.status,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);

  @override
  String toString() =>
      'RegisterResponse(data: $data, errorCode: $errorCode, errorNote: $errorNote, status: $status)';
}
