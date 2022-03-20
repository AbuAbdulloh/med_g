import 'package:flutter/material.dart';
import 'package:med_g/app/constants/colors.dart';

abstract class AppTheme {
  static ThemeData lightTheme() => ThemeData(
        fontFamily: 'Barlow',
        scaffoldBackgroundColor: background,
        canvasColor: background,
        textTheme: const TextTheme(
          headline1: headline1,
          headline2: headline2,
          headline3: headline3,
          headline4: headline4,
          headline5: headline5,
          headline6: headline6,
          bodyText1: bodyText1,
          // bodyText2: bodyText2,
          // button: bottonText,
        ),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          background: background,
          onBackground: dark,
          surface: background,
          onSurface: white,
          error: red,
          onError: white,
          primary: primary,
          onPrimary: white,
          secondary: secondary,
          onSecondary: white,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: dark,
        ),
      );

  static const headline1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: dark,
    fontFamily: 'Barlow',
  );
  static const headline2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: white,
    fontFamily: 'Barlow',
  );
  static const headline3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: grey,
    fontFamily: 'Barlow',
  );
  static const headline4 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: primary,
    fontFamily: 'Barlow',
  );

  static const headline5 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: red,
    fontFamily: 'Barlow',
  );

  static const headline6 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: secondary,
    fontFamily: 'Barlow',
  );

  static const bodyText1 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: secondary,
    fontFamily: 'Barlow',
  );
  // static var bodyText2 = TextStyle(
  //   fontSize: 14,
  //   fontWeight: FontWeight.w500,
  //   color: c516E95.withOpacity(0.5),
  //   fontFamily: 'Barlow',
  // );
  // static const bottonText = TextStyle(
  //   fontSize: 14,
  //   fontWeight: FontWeight.w500,
  //   color: regularTextDarkBlack,
  //   fontFamily: 'Barlow',
  // );
}
