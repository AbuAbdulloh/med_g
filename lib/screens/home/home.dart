import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:med_g/app/constants/app_icons.dart';
import 'package:med_g/app/theme/theme.dart';
import 'package:med_g/models/navbar/nav_bar.dart';
import 'package:med_g/models/navbar/nav_item_enum.dart';
import 'package:med_g/screens/home/navigator.dart';
import 'package:med_g/screens/home/widgets/nav_bar_item.dart';

class HomeScreen extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => const HomeScreen());

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _controller;
  late double navBarWidth;
  final List<double> wavePosition = [0.0, 0.2, 0.4, 0.6, 0.8];

  late AnimationController controller;
  final Map<NavItemEnum, GlobalKey<NavigatorState>> _navigatorKeys = {
    NavItemEnum.main: GlobalKey<NavigatorState>(),
    NavItemEnum.catalogue: GlobalKey<NavigatorState>(),
    NavItemEnum.orders: GlobalKey<NavigatorState>(),
    NavItemEnum.cart: GlobalKey<NavigatorState>(),
    NavItemEnum.profile: GlobalKey<NavigatorState>(),
  };

  List<NavBar> labels = [
    const NavBar(
      id: 0,
      iconOff: AppIcons.home,
      iconOn: AppIcons.home,
      title: 'Profile',
    ),
    const NavBar(
      id: 1,
      iconOff: AppIcons.doctor,
      iconOn: AppIcons.doctor,
      title: 'Doctor',
    ),
    const NavBar(
      id: 2,
      iconOff: AppIcons.message,
      iconOn: AppIcons.message,
      title: 'Chat',
    ),
    const NavBar(
      id: 3,
      iconOff: AppIcons.appointment,
      iconOn: AppIcons.appointment,
      title: 'Appointment',
    ),
    const NavBar(
      id: 4,
      iconOff: AppIcons.profile,
      iconOn: AppIcons.profile,
      title: 'Profile',
    ),
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    controller.addListener(() {});
    _controller = TabController(length: 5, vsync: this);
    _controller.addListener(onTabChange);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    super.initState();
  }

  void onTabChange() {
    setState(() => _currentIndex = _controller.index);
  }

  Widget _buildPageNavigator(NavItemEnum tabItem) => TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      );

  void changePage(int index) {
    setState(() => _currentIndex = index);
    _controller.animateTo(index);
  }

  @override
  Widget build(BuildContext context) => HomeTabControllerProvider(
        controller: _controller,
        child: WillPopScope(
          onWillPop: () async {
            final isFirstRouteInCurrentTab =
                !await _navigatorKeys[NavItemEnum.values[_currentIndex]]!
                    .currentState!
                    .maybePop();
            if (isFirstRouteInCurrentTab) {
              if (NavItemEnum.values[_currentIndex] != NavItemEnum.main) {
                changePage(0);
                return false;
              }
            }
            return isFirstRouteInCurrentTab;
          },
          child: Scaffold(
            backgroundColor: AppTheme.background,
            resizeToAvoidBottomInset: true,
            bottomNavigationBar: Container(
              height: 77,
              // margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 16),
              padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
              decoration: const BoxDecoration(
                // color: Color.fromRGBO(250, 251, 251, 1),
                color: AppTheme.cFCFDFF,
                // borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(6, 14, 34, 0.08),
                    blurRadius: 30,
                    offset: Offset(0, 0),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TabBar(
                    enableFeedback: true,
                    onTap: (int index) {},
                    indicator: const BoxDecoration(),
                    controller: _controller,
                    labelPadding: EdgeInsets.zero,
                    tabs: [
                      TabItemWidget(
                        isActive: _currentIndex == 0,
                        item: labels[0],
                      ),
                      TabItemWidget(
                        isActive: _currentIndex == 1,
                        item: labels[1],
                      ),
                      TabItemWidget(
                        isActive: _currentIndex == 2,
                        item: labels[2],
                      ),
                      TabItemWidget(
                        isActive: _currentIndex == 3,
                        item: labels[3],
                      ),
                      TabItemWidget(
                        isActive: _currentIndex == 4,
                        item: labels[4],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildPageNavigator(NavItemEnum.main),
                _buildPageNavigator(NavItemEnum.catalogue),
                _buildPageNavigator(NavItemEnum.orders),
                _buildPageNavigator(NavItemEnum.cart),
                _buildPageNavigator(NavItemEnum.profile),
              ],
            ),
          ),
        ),
      );
}

class HomeTabControllerProvider extends InheritedWidget {
  const HomeTabControllerProvider({
    required Widget child,
    required this.controller,
    Key? key,
  }) : super(key: key, child: child);

  final TabController controller;

  @override
  bool updateShouldNotify(HomeTabControllerProvider oldWidget) => false;

  static HomeTabControllerProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<HomeTabControllerProvider>()!;
}
