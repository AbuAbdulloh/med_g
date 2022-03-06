// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "welcome_main": "Welcome to your health page!"
};
static const Map<String,dynamic> ru = {
  "welcome_main": "Приветствуем тебя на твоей страничке здоровья!!!"
};
static const Map<String,dynamic> uz = {
  "welcome_main": "Salomatlik sahifangizga xush kelibsiz!"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ru": ru, "uz": uz};
}
