import 'package:med_g/data/singletons/dio_settings.dart';
import 'package:med_g/data/singletons/service_locator.dart';
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
      print(response.data);
      print(response.statusCode);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        print(RegisterResponse.fromJson(response.data));
        return RegisterResponse.fromJson(response.data);
      } else {
        throw Exception('${response.data}');
      }
    } on Exception catch (e) {
      throw Exception('$e');
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
        throw Exception('${response.data}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
