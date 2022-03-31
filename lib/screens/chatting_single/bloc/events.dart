
import 'package:med_g/models/chat/recieve_message.dart';

class ChatSingleEvents {}

class GetSingleChat extends ChatSingleEvents {
  final int id;

  GetSingleChat({required this.id});
}

class GetMoreSingleMessages extends ChatSingleEvents {}

class AddMessage extends ChatSingleEvents {
  final RecieveMessage message;

  AddMessage({required this.message});
}

class SendMessageEvent extends ChatSingleEvents {
  final int chatId;

  final String text;

  SendMessageEvent({required this.chatId, required this.text});
}

class AddSeenMessage extends ChatSingleEvents {
  final int messageId;

  AddSeenMessage({required this.messageId});
}

class SeeMessageEvent extends ChatSingleEvents {
  final int messageId;

  SeeMessageEvent({required this.messageId});
}

class AddChatCreateEvent extends ChatSingleEvents {
  final int chatId;

  AddChatCreateEvent({required this.chatId});
}

class CreateChatEvent extends ChatSingleEvents {
  final int userId;

  CreateChatEvent({required this.userId});
}

class DeleteChat extends ChatSingleEvents {
  final int chatId;

  DeleteChat({required this.chatId});
}
