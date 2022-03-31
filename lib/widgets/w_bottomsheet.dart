import 'package:flutter/widgets.dart';
import 'package:med_g/app/constants/colors.dart';

class WBottomSheet extends StatelessWidget {
  final double borderRadius;
  final List<Widget> children;
  final Widget? bottomNavigation;

  const WBottomSheet({
    required this.children,
    this.bottomNavigation,
    this.borderRadius = 12,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: 39,
            decoration: BoxDecoration(
              color: grey,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(borderRadius),
              ),
            ),
            margin: const EdgeInsets.only(top: 6),
            padding: EdgeInsets.fromLTRB(
                16,
                16,
                16,
                bottomNavigation == null
                    ? MediaQuery.of(context).padding.bottom + 16
                    : 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
          if (bottomNavigation != null) ...{
            Container(
              decoration: const BoxDecoration(
                color: white,
              ),
              padding: EdgeInsets.only(
                top: 32,
                bottom: MediaQuery.of(context).padding.bottom + 16,
              ),
              child: bottomNavigation,
            ),
          }
        ],
      );
}
