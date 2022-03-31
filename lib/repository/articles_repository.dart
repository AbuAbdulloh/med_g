import 'package:dio/dio.dart';
import 'package:med_g/data/singletons/dio_settings.dart';
import 'package:med_g/data/singletons/service_locator.dart';
import 'package:med_g/data/singletons/storage.dart';
import 'package:med_g/data/utils/custom_exception.dart';
import 'package:med_g/models/article/article.dart';
import 'package:med_g/models/article_single/article_single.dart';

class ArticleRepository {
  final _dio = serviceLocator<DioSettings>().dio;

  Future<List<Article>> getArticles() async {
    try {
      final response = await _dio.get(
        '/article/list',
        options: StorageRepository.getString('token').isNotEmpty
            ? Options(
                headers: {
                  'Authorization':
                      'Bearer ${StorageRepository.getString('token')}'
                },
              )
            : null,
      );
      print(response.data);
      print(response.data['data']);
      print(response.statusCode);
      print(response.realUri);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        try {
          return (response.data['data']['articles'] as List)
              .map((e) => Article.fromJson(e as Map<String, dynamic>))
              .toList();
        } catch (e) {
          throw const CustomException(
            message: 'Ma`lumot qabul qilishda xatolik yuz berdi',
            code: '141',
          );
        }
      } else {
        throw CustomException(
          message: '${response.data}',
          code: '${response.statusCode}',
        );
      }
    } on Exception catch (e) {
      print(e);
      throw CustomException(
        message: '$e',
        code: '141',
      );
    }
  }

  Future<ArticleSingle> getArticle({required String id}) async {
    try {
      final response = await _dio.get(
        '/article/$id',
        options: StorageRepository.getString('token').isNotEmpty
            ? Options(
                headers: {
                  'Authorization':
                      'Bearer ${StorageRepository.getString('token')}'
                },
              )
            : null,
      );
      print(response.data);
      print(response.data['data']);
      print(response.statusCode);
      print(response.realUri);
      print('In article single');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        try {
          return ArticleSingle.fromJson(response.data['data']);
        } catch (e) {
          throw const CustomException(
            message: 'Ma`lumot qabul qilishda xatolik yuz berdi',
            code: '141',
          );
        }
      } else {
        throw CustomException(
          message: '${response.data}',
          code: '${response.statusCode}',
        );
      }
    } on Exception catch (e) {
      print(e);
      throw CustomException(
        message: '$e',
        code: '141',
      );
    }
  }

  Future<List<Article>> getSavedArticles() async {
    print('in saved');
    try {
      final response = await _dio.get('/user/article/list',
          options: Options(
            headers: {
              'Authorization': 'Bearer ${StorageRepository.getString('token')}'
            },
          ));
      print(response.realUri);
      print(response.data);
      print(response.statusCode);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        try {
          return (response.data['data']['articles'] as List)
              .map((e) => Article.fromJson(e as Map<String, dynamic>))
              .toList();
        } catch (e) {
          throw const CustomException(
            message: 'Ma`lumot qabul qilishda xatolik yuz berdi',
            code: '141',
          );
        }
      } else {
        throw CustomException(
          message: '${response.data}',
          code: '${response.statusCode}',
        );
      }
    } on Exception catch (e) {
      print(e);
      throw CustomException(
        message: '$e',
        code: '141',
      );
    }
  }
}
