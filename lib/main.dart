import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:med_g/app/app.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/data/singletons/service_locator.dart';
import 'package:med_g/repository/authentication.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setupLocator();
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId('1d6c3a3d-639a-4d6c-a12a-e712ec4f9940');

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared
      .promptUserForPushNotificationPermission()
      .then((accepted) {});

  /// Used to disable pushing notifications
  // OneSignal.shared.disablePush(true);
  runApp(
    EasyLocalization(
      saveLocale: true,
      supportedLocales: const [
        Locale('uz'),
        Locale('ru'),
        Locale('en'),
      ],
      path: 'assets/translations',
      startLocale: const Locale('uz'),
      fallbackLocale: const Locale('uz'),
      child: const MyApp(),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MedG',
      theme: AppTheme.lightTheme(),
      home: App(authenticationRepository: AuthenticationRepository()),
    );
  }
}
