import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:med_g/data/singletons/dio_settings.dart';
import 'package:med_g/data/singletons/service_locator.dart';
import 'package:med_g/data/singletons/storage.dart';
import 'package:med_g/data/utils/custom_exception.dart';
import 'package:med_g/models/authenticated_user/authenticated_user.dart';
import 'package:med_g/models/authentication_status/authentication_status.dart';
import 'package:med_g/models/register/register.dart';
import 'package:med_g/models/register_response/register_response.dart';

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _dio = serviceLocator<DioSettings>().dio;
  Stream<AuthenticationStatus> get status async* {
    await StorageRepository.getInstance();
    await Future.delayed(const Duration(milliseconds: 1500));
    yield AuthenticationStatus.unauthenticated;

    yield* _controller.stream;
  }

  Future<void> logIn({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final response = await _dio
          .post('/login', data: {'phone': phoneNumber, 'password': password});
      print(response.data);
      print(response.statusCode);
      print(response.realUri);
      print('In login');
      print(response.data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        try {
          await StorageRepository.putString(
            'refresh',
            response.data['data']['token']['refresh'],
          );
          await StorageRepository.putString(
            'token',
            response.data['data']['token']['access'],
          );
          _controller.add(
            AuthenticationStatus.authenticated,
          );
        } catch (e) {
          throw CustomException(message: '$e', code: '502');
        }
      } else {
        final message = '${(response.data as Map<String, dynamic>)}'
            .replaceAll(RegExp(r'[\[\]]'), '');
        throw CustomException(
          message: message,
          code: '${response.statusCode}',
        );
      }
    } on Exception catch (e) {
      throw CustomException(message: '$e', code: '502');
    }
  }

  Future<AuthenticatedUser> getProfile() async {
    print(StorageRepository.getString('token'));
    print(StorageRepository.getString('refresh'));
    print('Authorization: Bearer ${StorageRepository.getString('token')}');
    final _dio = serviceLocator<DioSettings>().dio;
    final response = await _dio.get(
      '/user/profile',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${StorageRepository.getString('token')}'
        },
      ),
    );
    print(response.data);
    print(response.statusCode);
    print(response.realUri);
    print(response.requestOptions.headers);
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return AuthenticatedUser.fromJson(response.data['data']);
    } else {
      throw CustomException(message: '${response.data}', code: '100');
    }
  }

  Future<void> refreshToken() async {
    print('refreshing token');
    try {
      final response = await _dio.post(
        '/auth/refresh',
        data: {
          'token': StorageRepository.getString('refresh'),
        },
      );
      print(response.requestOptions.data);
      print(response.data);
      print(response.statusCode);
      print(response.realUri);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        await StorageRepository.putString(
            'refresh', response.data['data']['token']['refresh']);
        await StorageRepository.putString(
            'token', response.data['data']['token']['access']);
      } else {
        throw CustomException(
          message: '${response.data}',
          code: '${response.statusCode}',
        );
      }
    } catch (e) {
      throw CustomException(
        message: '$e',
        code: '141',
      );
    }
  }

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
      print(code);
      print(signId);
      print(phone);
      print(firstName);
      print(password);
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
        StorageRepository.putString(
            'token', response.data['data']['token']['access']);
        StorageRepository.putString(
            'refresh', response.data['data']['token']['refresh']);
        _controller.add(AuthenticationStatus.authenticated);
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

  Future<AuthenticatedUser> updateProfile({
    required AuthenticatedUser user,
  }) async {
    print('send data: $user');
    try {
      final response = await _dio.put(
        '/user/update',
        data: {
          'address': user.address,
          'allergy': user.allergy,
          'birth_date': user.birthDate,
          'first_name': user.firstName,
          'height': user.height,
          'hobby': user.hobby,
          'patronymic': user.patronymic,
          'weight': user.weight,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${StorageRepository.getString('token')}'
          },
        ),
      );
      print('Updated profile');
      print('This is body request: ${response.requestOptions.data}');
      print('This is response body: ${response.data}');
      print(response.realUri);
      print(response.statusCode);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        try {
          print(AuthenticatedUser.fromJson(response.data['data']));
          return AuthenticatedUser.fromJson(response.data['data']);
        } on Exception catch (e) {
          print('Error occured');
          print(e);
          throw CustomException(message: '$e', code: '141');
        }
      } else {
        throw CustomException(
          message: '${response.data}',
          code: '${response.statusCode}',
        );
      }
    } on CustomException {
      rethrow;
    } on Exception catch (e) {
      throw CustomException(message: '$e', code: '141');
    }
  }

  Future<void> uploadImage({required String imageUrl}) async {
    try {
      final form = FormData.fromMap(
        {
          'image': await MultipartFile.fromFile(imageUrl),
        },
      );
      final response = await _dio.post(
        '/user/image',
        data: form,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${StorageRepository.getString('token')}'
          },
        ),
      );
      print(response.data);
      print(response.statusCode);
      print(response.realUri);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        print('succes image upload');
      } else {
        throw CustomException(
          message: '${response.data}',
          code: '${response.statusCode}',
        );
      }
    } on CustomException {
      rethrow;
    } catch (e) {
      throw CustomException(message: '$e', code: '141');
    }
  }

  Future<void> logOut() async {
    await StorageRepository.putString('token', '');
    await StorageRepository.putString('refresh', '');
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
