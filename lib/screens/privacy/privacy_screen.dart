import 'package:flutter/material.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/screens/privacy/widgets/privacy_item.dart';
import 'package:med_g/widgets/w_app_bar.dart';

class PrivacyScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => const PrivacyScreen(),
      );
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: PreferredSize(
        child: WAppBar(title: 'Privacy Policy', mediaQuery: mediaQuery),
        preferredSize: const Size.fromHeight(77),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 22, left: 14, right: 14),
        child: PrivacyItem(
          title: 'Privacy Policy',
          items: [
            Text(
              '''
The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years.

web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web site.
              ''',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
