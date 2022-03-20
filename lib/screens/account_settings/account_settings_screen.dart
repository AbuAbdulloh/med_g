import 'package:flutter/material.dart';
import 'package:med_g/app/constants/colors.dart';

class AccountSettings extends StatefulWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => const AccountSettings(),
      );
  const AccountSettings({Key? key}) : super(key: key);

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Container(),
    );
  }
}
