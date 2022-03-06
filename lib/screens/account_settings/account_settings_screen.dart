import 'package:flutter/material.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/screens/account_settings/widgets/account_settings_app_bar.dart';
import 'package:med_g/screens/account_settings/widgets/account_settings_container.dart';
import 'package:med_g/screens/account_settings/widgets/account_settings_item.dart';

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
      backgroundColor: AppTheme.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mediaQuery.padding.top + 264),
        child: AccountSettingsAppBar(mediaQuery: mediaQuery),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: const EdgeInsets.only(
          top: 43,
          left: 14,
          right: 14,
          bottom: 10,
        ),
        children: [
          AccountSettingsContainer(
            title: 'Personal Info',
            onEditTap: () {},
            items: const [
              AccountSettingsItem(
                title: 'First Name',
                text: 'Lucy',
              ),
              AccountSettingsItem(
                title: 'Last Name',
                text: 'Martin',
              ),
              AccountSettingsItem(
                title: 'Username',
                text: 'lucymartin',
              ),
              AccountSettingsItem(
                title: 'Phone No.',
                text: '+91 9876543210',
              ),
              AccountSettingsItem(
                title: 'Location',
                text: 'Ahmedabad',
              ),
              AccountSettingsItem(
                title: 'Address',
                text: '''
Shoppers Plaza-4,
C.G Road, Ahmedabad
Gujarat, India.
''',
              ),
            ],
          ),
          const SizedBox(height: 22),
          AccountSettingsContainer(
            title: 'Account Info',
            onEditTap: () {},
            items: const [
              AccountSettingsItem(
                title: 'Email',
                text: 'lucymartin@gmail.com',
              ),
              AccountSettingsItem(
                title: 'Password',
                text: '********',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
