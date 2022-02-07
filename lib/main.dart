import 'package:flutter/material.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/screens/login/login_screen.dart';
import 'package:med_g/screens/splash/splash_screen.dart';
import 'package:med_g/screens/verification/verification_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MEDG',
      theme: AppTheme.lightTheme(),
      home: const VerificationScreen(),
    );
  }
}
