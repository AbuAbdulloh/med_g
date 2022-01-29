import 'package:flutter/material.dart';
import 'package:med_g/widgets/w_app_bar.dart';

class SupportScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => const SupportScreen(),
      );
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: PreferredSize(
        child: WAppBar(
          title: 'Support',
          mediaQuery: mediaQuery,
        ),
        preferredSize: Size.fromHeight(mediaQuery.padding.top + 77),
      ),
      body: Container(),
    );
  }
}
