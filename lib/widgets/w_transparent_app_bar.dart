import 'package:flutter/material.dart';
import 'package:med_g/widgets/w_back_button.dart';

class WTransparentAppBar extends StatelessWidget with PreferredSizeWidget {
  const WTransparentAppBar({
    Key? key,
    required this.mediaQuery,
  }) : super(key: key);

  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: Container(
        padding: EdgeInsets.only(top: mediaQuery.padding.top),
        child: Row(
          children: const [
            Padding(
              padding: EdgeInsets.all(16),
              child: WBackButton(),
            ),
          ],
        ),
      ),
      preferredSize: Size.fromHeight(mediaQuery.padding.top + 55),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(mediaQuery.padding.top + 55);
}
