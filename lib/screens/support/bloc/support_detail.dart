import 'package:flutter/material.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/screens/account_settings/widgets/account_settings_container.dart';
import 'package:med_g/screens/support/bloc/support_detail_item.dart';
import 'package:med_g/widgets/w_app_bar.dart';

class SupprotDetail extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) {
        return const SupprotDetail();
      });
  const SupprotDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mediaQuery.padding.top + 77),
        child: WAppBar(title: 'Support', mediaQuery: mediaQuery),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 22, left: 14, right: 14),
        child: SupprotDetailItem(
          title: 'How to delete account?',
          items: [
            Text(
              '''
when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently.

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
