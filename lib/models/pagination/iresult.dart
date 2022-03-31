import 'package:equatable/equatable.dart';
import 'package:med_g/models/chat/chat.dart';
import 'package:med_g/models/chat/chat_message.dart';

class IResult extends Equatable {
  const IResult();

  factory IResult.fromJson(Map<String, dynamic> x, IResult type) {
    if (type is Chat) {
      return Chat.fromJson(x);
    } else if (type is ChatMessage) {
      return ChatMessage.fromJson(x);
    }

    return const IResult();
  }

  @override
  List<Object?> get props => [];
}
