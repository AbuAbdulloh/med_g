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
  "welcome_main": "Go to main",
  "continueing": "Continue",
  "advice": "Advice from experts",
  "advice_desc": "Find a doctor who will take the best care of your health",
  "planned_care": "Planned treatment regimen",
  "planned_care_desc": "Make a note to yourself about taking your medications on time",
  "order_medicine": "Order Medicine Online",
  "order_medicine_desc": "Order your medicine that your doctor provided you",
  "login": "Login",
  "signup": "Register"
};
static const Map<String,dynamic> ru = {
  "welcome_main": "Перейти к основному",
  "continueing": "Продолжать",
  "advice": "Совет от экспертов",
  "advice_desc": "Найдите врача, который лучше всех позаботится о вашем здоровье",
  "planned_care": "Плановая схема лечения",
  "planned_care_desc": "Поставьте себе заметку о своевременном приеме лекарств",
  "order_medicine": "Заказать лекарства онлайн",
  "order_medicine_desc": "Закажите лекарство, которое выврач дал вам",
  "login": "Логин",
  "signup": "Зарегистрироваться"
};
static const Map<String,dynamic> uz = {
  "welcome_main": "Asosiyga o’tish",
  "continueing": "Davom etish",
  "advice": "Ekspertlardan maslahatlar",
  "advice_desc": "Sizga g'amxo'rlik qila oladigan eng yaxshi doktorni toping",
  "planned_care": "Rejalashtirilgan davolanish tartibi",
  "planned_care_desc": "Dori-darmonlarni o'z vaqtida qabul qilish uchun eslatma o'rnating",
  "order_medicine": "Dorilarni onlayn buyurtma qiling",
  "order_medicine_desc": "Shifokorlar yozib bergan retsept asosida dorilarni onlayn buyurtma qiling",
  "login": "Kirish",
  "signup": "Ro’yxatdan o’tish"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ru": ru, "uz": uz};
}
