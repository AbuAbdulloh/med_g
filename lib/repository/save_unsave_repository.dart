import 'dart:async';

import 'package:dio/dio.dart';
import 'package:med_g/data/singletons/dio_settings.dart';
import 'package:med_g/data/singletons/service_locator.dart';
import 'package:med_g/data/singletons/storage.dart';
import 'package:med_g/data/utils/custom_exception.dart';

class SaveUnsaveRepository {
  final StreamController<String> controller =
      StreamController.broadcast(sync: true);

  Stream<String> get articleStream async* {
    yield* controller.stream;
  }

  final _dio = serviceLocator<DioSettings>().dio;
  Future<void> saveArticle(String id) async {
    try {
      final response = await _dio.post(
        '/saved/article',
        data: {
          'article_id': id,
          'condition': 'save',
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${StorageRepository.getString('token')}'
          },
        ),
      );
      print(response.data);
      print(response.statusCode);
      print(response.realUri);
      print(response.requestOptions.data);
      if (!(response.statusCode! >= 200 && response.statusCode! < 300)) {
        throw CustomException(
          message: '${response.data}',
          code: '${response.statusCode}',
        );
      } else {
        print('saved');
        controller.add(id);
      }
    } on CustomException {
      rethrow;
    } on Exception catch (e) {
      throw CustomException(
        message: '$e',
        code: '$e',
      );
    }
  }

  Future<void> unsavearticle(String id) async {
    try {
      final response = await _dio.post(
        '/saved/article',
        data: {
          'article_id': id,
          'condition': 'remove',
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${StorageRepository.getString('token')}'
          },
        ),
      );
      print(response.data);
      print(response.statusCode);
      print(response.realUri);
      print(response.requestOptions.data);
      if (!(response.statusCode! >= 200 && response.statusCode! < 300)) {
        throw CustomException(
          message: '${response.data}',
          code: '${response.statusCode}',
        );
      } else {
        print('unsaved');
        controller.add(id);
      }
    } on CustomException {
      rethrow;
    } on Exception catch (e) {
      throw CustomException(
        message: '$e',
        code: '$e',
      );
    }
  }

  void close() {
    controller.close();
  }
}
