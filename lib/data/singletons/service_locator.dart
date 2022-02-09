import 'package:get_it/get_it.dart';
import 'package:med_g/data/singletons/dio_settings.dart';

final serviceLocator = GetIt.I;

void setupLocator() {
  serviceLocator.registerLazySingleton(DioSettings.new);
}
