import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:med_g/data/singletons/dio_settings.dart';
import 'package:med_g/data/singletons/service_locator.dart';
import 'package:med_g/data/singletons/storage.dart';
import 'package:med_g/data/utils/custom_exception.dart';
import 'package:med_g/models/authenticated_user/authenticated_user.dart';
import 'package:med_g/models/authentication_status/authentication_status.dart';

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _dio = serviceLocator<DioSettings>().dio;
  Stream<AuthenticationStatus> get status async* {
    await StorageRepository.getInstance();
    await Future.delayed(const Duration(milliseconds: 1500));
    yield AuthenticationStatus.unauthenticated;

    yield* _controller.stream;
  }

  Future<AuthenticatedUser> logIn({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {
          'phone': phoneNumber,
          'password': password,
        },
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        await StorageRepository.putString(
            'token', response.data['data']['token']);
        return AuthenticatedUser.fromJson(response.data['data']['user']);
      } else {
        final message =
            '${(response.data as Map<String, dynamic>).values.first}'
                .replaceAll(RegExp(r'[\[\]]'), '');
        throw CustomException(
          message: message,
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

  Future<AuthenticatedUser> getProfile() async {
    final _dio = serviceLocator<DioSettings>().dio;
    await Future.delayed(const Duration(seconds: 3));
    return AuthenticatedUser.fromJson(const {});
    // final response = await _dio.get(
    //   '/login',
    // options: Options(
    //   headers: {
    //     'Authorization': 'Bearer ${StorageRepository.getString("token")}'
    //   },
    // ),
    // );

    // if (response.statusCode! >= 200 && response.statusCode! < 300) {
    //   return AuthenticatedUser.fromJson(response.data['data']);
    // } else {
    //   final message = '${(response.data as Map<String, dynamic>).values.first}'
    //       .replaceAll(RegExp(r'[\[\]]'), '');

    //   throw CustomException(message: message, code: '100');
    // }
  }

  Future<AuthenticatedUser> refreshToken() async {
    final response = await _dio.post(
      'auth/token/refresh/',
      data: {
        'refresh': StorageRepository.getString('refresh'),
      },
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      // TODO: Implement refresh token
      return AuthenticatedUser.fromJson(const {});
    } else {
      return AuthenticatedUser.fromJson(const {});
    }
  }

  AuthenticatedUser getProfiles() {
    final userList = (StorageRepository.getList('users', defValue: []))
        .map(
          (e) => AuthenticatedUser.fromJson(json.decode(e)),
        )
        .toList();

    return userList.first;
  }

  Future<void> logOut() async {
    // StorageRepository.putList('users', defValue: []);
    await StorageRepository.putString('token', '');
    await StorageRepository.putString('refresh', '');
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
