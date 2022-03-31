import 'package:json_annotation/json_annotation.dart';
import 'package:med_g/models/chat/chat_message.dart';

part 'recieve_message.g.dart';

@JsonSerializable()
class RecieveMessage {
  @JsonKey(name: 'action',defaultValue: '')
  final String action;
   @JsonKey(name: 'type',defaultValue: '')
  final String type;
   @JsonKey(name: 'status',defaultValue: '')
  final String status;
   @JsonKey(name: 'data')
  final ChatMessage data;
  RecieveMessage(
      {required this.action,
      required this.data,
      required this.type,
      required this.status});

factory RecieveMessage.fromJson(Map<String,dynamic> json)=>_$RecieveMessageFromJson(json);

      Map<String,dynamic> toJson()=>_$RecieveMessageToJson(this);
}
