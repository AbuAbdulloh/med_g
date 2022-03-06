import 'package:med_g/data/singletons/dio_settings.dart';
import 'package:med_g/data/singletons/service_locator.dart';
import 'package:med_g/data/singletons/storage.dart';
import 'package:med_g/data/utils/custom_exception.dart';
import 'package:med_g/models/authenticated_user/authenticated_user.dart';
import 'package:med_g/models/register/register.dart';
import 'package:med_g/models/register_response/register_response.dart';

class RegisterRepository {
  final _dio = serviceLocator<DioSettings>().dio;

  Future<RegisterResponse> registerUser(Register register) async {
    try {
      final response = await _dio.post(
        '/send-code',
        data: {
          'phone': register.phone,
        },
      );
      print(response.data);
      print(response.statusCode);
      print(response.realUri);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return RegisterResponse.fromJson(response.data);
      } else {
        throw CustomException(
          message: '${response.data['error_note']}',
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

  Future<AuthenticatedUser> confirmUser({
    required int code,
    required String signId,
    required String phone,
    required String firstName,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/register',
        data: {
          'code': code,
          'first_name': firstName,
          'password': password,
          'phone': phone,
          'sign_id': signId,
        },
      );
      print(response.data);
      print(response.statusCode);
      print(response.realUri);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        print(response.data);
        print(response.statusCode);
        StorageRepository.putString('token', response.data['data']['token']);
        return AuthenticatedUser.fromJson(response.data['data']['user']);
      } else {
        print(response.data);
        print(response.statusCode);
        print(response.realUri);
        throw CustomException(
          message: '${response.data['error_note']}',
          code: '${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> loginUser(Map<String, dynamic> data) async {
  //   print(data);
  //   try {
  //     final response = await _dio.post(
  //       '/login',
  //       data: data,
  //     );
  //     print(response.data);
  //     if (response.statusCode! >= 200 && response.statusCode! < 300) {
  //       print(response.data);
  //       print(response.statusCode);
  //     } else {
  //       throw CustomException(
  //         message: '${response.data['status']}',
  //         code: '${response.statusCode}',
  //       );
  //     }
  //   } on CustomException {
  //     rethrow;
  //   } on Exception catch (e) {
  //     throw CustomException(message: '$e', code: '502');
  //   }
  // }
}
