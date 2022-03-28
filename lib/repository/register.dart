import 'package:med_g/data/singletons/dio_settings.dart';
import 'package:med_g/data/singletons/service_locator.dart';
import 'package:med_g/data/singletons/storage.dart';
import 'package:med_g/data/utils/custom_exception.dart';
import 'package:med_g/models/authenticated_user/authenticated_user.dart';
import 'package:med_g/models/register/register.dart';
import 'package:med_g/models/register_response/register_response.dart';

class RegisterRepository {
  final _dio = serviceLocator<DioSettings>().dio;

  
}
