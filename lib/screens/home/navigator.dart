import 'package:flutter/cupertino.dart';
import 'package:med_g/models/navbar/nav_item_enum.dart';
import 'package:med_g/screens/chat/chat_screen.dart';
import 'package:med_g/screens/doctor/doctor_screen.dart';
import 'package:med_g/screens/main/main_screen.dart';
import 'package:med_g/screens/profile/profile_screen.dart';

class TabNavigatorRoutes {
  static const String root = '/';
}

class TabNavigator extends StatefulWidget {
  const TabNavigator(
      {Key? key, required this.navigatorKey, required this.tabItem})
      : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey;
  final NavItemEnum tabItem;

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator>
    with AutomaticKeepAliveClientMixin {
  Map<String, WidgetBuilder> _routeBuilders(
      {required BuildContext context, required RouteSettings settings}) {
    switch (widget.tabItem) {
      case NavItemEnum.main:
        return {
          TabNavigatorRoutes.root: (context) => const MainScreen(),
        };
      case NavItemEnum.catalogue:
        return {
          TabNavigatorRoutes.root: (context) => const DoctorScreen(),
        };
      case NavItemEnum.orders:
        return {
          TabNavigatorRoutes.root: (context) => const ChatScreen(),
        };
      case NavItemEnum.cart:
        return {
          TabNavigatorRoutes.root: (context) => const SizedBox.shrink(),
        };
      case NavItemEnum.profile:
        return {
          TabNavigatorRoutes.root: (context) => const ProfileScreen(),
        };

      default:
        return {
          TabNavigatorRoutes.root: (context) => Container(),
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Navigator(
      key: widget.navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        final routeBuilders =
            _routeBuilders(context: context, settings: routeSettings);

        return CupertinoPageRoute<dynamic>(
          builder: (context) => routeBuilders.containsKey(routeSettings.name)
              ? routeBuilders[routeSettings.name]!(
                  context,
                )
              : Container(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

PageRouteBuilder fade({
  required Widget page,
}) =>
    PageRouteBuilder<Widget>(
      transitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            1,
            curve: Curves.linear,
          ),
        ),
        child: child,
      ),
      pageBuilder: (context, animation, secondaryAnimation) => page,
    );
