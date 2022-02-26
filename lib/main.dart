import 'package:flutter/material.dart';
import 'package:med_g/app/app.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/data/singletons/service_locator.dart';
import 'package:med_g/repository/authentication.dart';
import 'package:med_g/screens/splash/splash_screen.dart';

void main() {
  setupLocator();
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
      home: App(
        authenticationRepository: AuthenticationRepository(),
      ),
    );
  }
}
