import 'package:json_annotation/json_annotation.dart';


part 'send_message.g.dart';

@JsonSerializable()
class SendMessage {
  @JsonKey(name: 'action',defaultValue: '')
  final String action;
  @JsonKey(name: 'data')
  final Map<String,dynamic> data ;
  SendMessage({required this.action,required this.data});

factory SendMessage.fromJson(Map<String, dynamic> json) => _$SendMessageFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageToJson(this);
}