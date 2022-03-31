import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:med_g/data/singletons/dio_settings.dart';
import 'package:med_g/data/singletons/service_locator.dart';
import 'package:med_g/data/singletons/storage.dart';
import 'package:med_g/data/utils/custom_exception.dart';
import 'package:med_g/models/chat/chat.dart';
import 'package:med_g/models/chat/chat_message.dart';
import 'package:med_g/models/pagination/custom_pagination.dart';
import 'package:web_socket_channel/io.dart';

class ChatRepository {


  final _dio = serviceLocator<DioSettings>().dio;
  final streamController = StreamController.broadcast(sync: true);
  final messageSocket = IOWebSocketChannel.connect(
    Uri.parse('wss://jobhunt.xn--h28h.uz/ws/main'),
    headers: {'token': StorageRepository.getString('token')},
  );

  void transformSocket() {
    streamController.addStream(messageSocket.stream);
  }

  Stream<dynamic> get messageStream async* {
    yield* streamController.stream;
  }

  @override
  void dispose() {
    streamController.close();
  }

  void sendMessage({required String text, required int chatId}) {
    try {
      messageSocket.sink.add(jsonEncode({
        'action': 'message__create',
        'data': {'chat': chatId, 'body': text}
      }));
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  void seeMessage({required int id}) {
    try {
      messageSocket.sink.add(jsonEncode({
        'action': 'message__see',
        'data': {'id': id}
      }));
      print('good see message');
    } on DioError catch (e) {
      print(e.toString() + 'see message');
    }
  }

  void deleteChat({required int chatId}) {
    try {
      messageSocket.sink.add(jsonEncode({
        'action': 'chat__delete',
        'data': {'id': chatId}
      }));
      print('good see message');
    } on DioError catch (e) {
      print(e.toString() + 'see message');
    }
  }

  void createChat({required int userId}) {
    try {
      messageSocket.sink.add(jsonEncode({
        'action': 'chat__create',
        'data': {'worker': userId}
      }));
      print('good create chat');
    } on DioError catch (e) {
      print(e.toString() + 'bad create chat');
    }
  }


  Future<List<Chat>> getChatList({required bool isCompany}) async {
    final response = await _dio.get(isCompany?'/chat/company/chats/list': '/chat/worker/chats/list',
        options: Options(headers: {
          'Authorization': 'Bearer ${StorageRepository.getString('token')}'
        }));
    print(response.data);
    print(response.realUri);
    print(response.statusCode);
    try {
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final result = response.data['results'] as List<dynamic>;
        final list = result
            .map((e) => Chat.fromJson(e as Map<String, dynamic>))
            .toList();
        return list;
      } else {
        throw const CustomException(message: 'error', code: '141');
      }
    }on DioError catch (e) {
      print(e.toString());
      throw CustomException(message: e.toString(), code: '141');
    }
  }

  Future<CustomPagination> getSinglChat(int id) async {
    final response = await _dio.get('chat/chats/$id/messages',
        options: Options(headers: {
          'Authorization': 'Bearer ${StorageRepository.getString('token')}'
        }));
    print(response.data);
    print(response.realUri);
    print(response.statusCode);
    try {
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final result = response.data['results'] as List<dynamic>;
        final list =
            CustomPagination.fromJson(response.data, ChatMessage.fromJson({}));
        return list;
      } else {
        throw const CustomException(message: 'error', code: '141');
      }
    } catch (e) {
      print(e.toString());
      throw CustomException(message: e.toString(), code: '141');
    }
  }

}
