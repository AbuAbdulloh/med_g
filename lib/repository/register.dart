import 'package:med_g/data/singletons/dio_settings.dart';
import 'package:med_g/data/singletons/service_locator.dart';
import 'package:med_g/data/utils/custom_exception.dart';
import 'package:med_g/models/register/register.dart';
import 'package:med_g/models/register_response/register_response.dart';

class RegisterRepository {
  final _dio = serviceLocator<DioSettings>().dio;

  Future<RegisterResponse> registerUser(Register register) async {
    try {
      final response = await _dio.post(
        '/register',
        data: register.toJson(),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return RegisterResponse.fromJson(response.data);
      } else {
        throw CustomException(
          message: '${response.data['status']}',
          code: '${response.statusCode}',
        );
      }
    } on Exception catch (e) {
      throw CustomException(
        message: '$e',
        code: '502',
      );
    }
  }

  Future<void> confirmUser({
    required int code,
    required String signId,
    required String userId,
  }) async {
    try {
      final response = await _dio.post(
        '/confirm',
        data: {
          "code": code,
          "sign_id": signId,
          "user_id": userId,
        },
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        print(response.data);
        print(response.statusCode);
      } else {
        throw CustomException(
          message: '${response.data['status']}',
          code: '${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loginUser(Map<String, dynamic> data) async {
    print(data);
    try {
      final response = await _dio.post(
        '/login',
        data: data,
      );
      print(response.data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        print(response.data);
        print(response.statusCode);
      } else {
        throw CustomException(
          message: '${response.data['status']}',
          code: '${response.statusCode}',
        );
      }
    } on CustomException {
      rethrow;
    } on Exception catch (e) {
      throw CustomException(message: '$e', code: '502');
    }
  }
}
