import 'package:json_annotation/json_annotation.dart';

part 'send_body.g.dart';

@JsonSerializable()
class SendBody {
  @JsonKey(name: 'chat',defaultValue: 0)
  final int chatId ;
  @JsonKey(name: 'body',defaultValue: '')
  final  String message;
  SendBody({required this. chatId,required this.message});

factory SendBody.fromJson(Map<String, dynamic> json) => _$SendBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SendBodyToJson(this);

}