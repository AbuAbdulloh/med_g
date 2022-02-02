import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData lightTheme() => ThemeData(
        fontFamily: 'Barlow',
        scaffoldBackgroundColor: background,
        canvasColor: background2,
        textTheme: TextTheme(
          headline1: headline1,
          headline2: headline2,
          headline3: headline3,
          headline4: headline4,
          headline5: headline5,
          headline6: headline6,
          bodyText1: bodyText1,
          bodyText2: bodyText2,
          button: bottonText,
        ),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          background: background,
          onBackground: c65B136,
          surface: background2,
          onSurface: cFFF9DD,
          error: red,
          onError: cFFEEEE,
          primary: primary, //y
          onPrimary: onPrimary, //y
          primaryVariant: primaryAccent, //y
          secondary: regularTextGrey,
          onSecondary: regularTextDarkGrey,
          secondaryVariant: regularTextDarkBlack, //y
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: primaryAccent,
          // selectionColor: Colors.transparent,
          // selectionHandleColor: Colors.transparent,
        ),
      );

  static const regularDisabled = Color(0xffAAACB6);
  static const primaryAccent = Color(0xff292929);
  static const primary = Color(0xffFFCB15);
  static const regularText = Color(0xff3F4254);
  static const apptheme = Color(0xffF5F8FC);
  static const regularTextDarkBlack = Color(0xff383838);
  static const regularTextDarkBlue = Color(0xff525F73);
  static const regularTextDarkGrey = Color(0xff9E9EA5);
  static const regularTextGrey = Color(0xffD5D5D5);
  static const background = Color(0xFFF3F8FF);
  static const background2 = Color(0xffF4F5F7); //Color(0xffF2F3F5);
  static const c65B136 = Color(0xff65B136);
  static const c51C192 = Color(0xff51C192);
  static const onPrimary = Color(0xffFFCB15);
  static const main = Color(0XFF1D3A62);
  static const cEBEBEB = Color(0xffEBEBEB);
  static const cFFF9DD = Color(0xffFFF9DD);
  static const red = Color(0xffF9524E);
  static const c516E95 = Color(0XFF516E95);
  static const cFFEEEE = Color(0xffFFEEEE);
  static const cF2F3F5 = Color(0xffF2F3F5);
  static const cF6F6F6 = Color(0xffF6F6F6);
  static const cC0D4F4 = Color(0xffC0D4F4);
  static const dark = Color(0xff000000);
  static const redAccent = Color(0xFFE8425E);
  static const cD7D8DD = Color(0xffD7D8DD);
  static const c363853 = Color(0xff363853);
  static const c9E9EA5 = Color(0xff9E9EA5);
  static const c3E434D = Color(0xff3E434D);
  static const cB3B6BD = Color(0xffB3B6BD);
  static const cF9524E = Color(0xffF9524E);
  static const cE50827 = Color(0xffE50827);
  static const neutral = Color(0xff80808F);
  static const cFFF0E5 = Color(0xffFFF0E5);
  static const cE3F5ED = Color(0xffE3F5ED);
  static const cE5F6FE = Color(0xffE5F6FE);
  static const cFBE5FE = Color(0xffFBE5FE);
  static const black = Color(0xff000000);
  static const cF0F2F5 = Color(0xffF0F2F5);
  static const cC5C5C5 = Color(0xffC5C5C5);
  static const c121212 = Color(0xff121212);
  static const cE9EEF3 = Color(0xffE9EEF3);
  static const cECF1FB = Color(0xffECF1FB);
  static const cC9C9C9 = Color(0xffC9C9C9);
  static const c9D9D9D = Color(0xff9D9D9D);
  static const cFEEEEE = Color(0xffFEEEEE);
  static const cEFF5FE = Color(0xffEFF5FE);
  static const cE6E7E9 = Color(0xffE6E7E9);
  static const c1C9DDD = Color(0xff1C9DDD);
  static const cEAEBED = Color(0xffEAEBED);
  static const cF64E60 = Color(0xffF64E60);
  static const c80808F = Color(0xff80808F);
  static const c356AD1 = Color(0xff356AD1);
  static const cD5D5D5 = Color(0xffD5D5D5);
  static const c3F4254 = Color(0xff3F4254);
  static const cA2ABBE = Color(0xffA2ABBE);
  static const c464E5F = Color(0xff464E5F);
  static const cEAECF0 = Color(0xffEAECF0);
  static const cF3F5F7 = Color(0xffF3F5F7);
  static const cA6AAB1 = Color(0xffA6AAB1);
  static const cDFE2E9 = Color(0xffDFE2E9);
  static const cF7F7F7 = Color(0xffF7F7F7);
  static const cE1E6F0 = Color(0xffE1E6F0);
  static const cC6C6C6 = Color(0xffC6C6C6);
  static const cE5E5E5 = Color(0xffE5E5E5);
  static const c424343 = Color(0xff424343);
  static const white = Color(0xffFFFFFF);
  static const cF0CB23 = Color(0xffFFCB15);
  static const c2261AA = Color(0xff2261AA);
  static const cFCFDFF = Color(0XFFFCFDFF);
  static const c1479FF = Color(0XFF1479FF);
  static const cB4C7DE = Color(0XFFB4C7DE);
  static const c82A3CA = Color(0xFF82A3CA);
  static const c4AC989 = Color(0XFF4AC989);
  static const c4485FC = Color(0XFF4485FC);
  static const green = Color(0XFF26D7AC);
  static const headline1 = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: main,
    fontFamily: 'Barlow',
  );
  static const headline2 = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: white,
    fontFamily: 'Barlow',
  );
  static const headline3 = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: regularTextDarkBlue,
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
    color: Color(0xff6B6C6F),
    fontFamily: 'Barlow',
  );

  static const headline6 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: red,
    fontFamily: 'Barlow',
  );

  static const bodyText1 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: c516E95,
    fontFamily: 'Barlow',
  );
  static var bodyText2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: c516E95.withOpacity(0.5),
    fontFamily: 'Barlow',
  );
  static const bottonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: regularTextDarkBlack,
    fontFamily: 'Barlow',
  );
}
