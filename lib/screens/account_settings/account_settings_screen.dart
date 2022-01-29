import 'package:flutter/material.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/screens/account_settings/widgets/account_settings_app_bar.dart';

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
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppTheme.cF3F8FF,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mediaQuery.padding.top + 264),
        child: AccountSettingsAppBar(mediaQuery: mediaQuery),
      ),
      body: Container(),
    );
  }
}
