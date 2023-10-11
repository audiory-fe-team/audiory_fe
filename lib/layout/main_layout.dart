import 'package:audiory_v0/layout/app_bar_navigator.dart';
import 'package:audiory_v0/layout/tab_navigator.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class AppMainLayout extends StatefulWidget {
  const AppMainLayout({super.key});

  @override
  State<AppMainLayout> createState() => _AppMainLayoutState();
}

class _AppMainLayoutState extends State<AppMainLayout> {
  String _currentPage = "Home";
  List<String> pageKeys = ["Home", "Explore", "Library", 'Writer', "Profile"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Explore": GlobalKey<NavigatorState>(),
    "Library": GlobalKey<NavigatorState>(),
    "Writer": GlobalKey<NavigatorState>(),
    "Profile": GlobalKey<NavigatorState>(),
  };
  Map<String, GlobalKey<NavigatorState>> _appBarNavigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Explore": GlobalKey<NavigatorState>(),
    "Library": GlobalKey<NavigatorState>(),
    "Writer": GlobalKey<NavigatorState>(),
    "Profile": GlobalKey<NavigatorState>(),
  };

  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
              !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
          if (isFirstRouteInCurrentTab) {
            if (_currentPage != "Home") {
              _selectTab("Home", 1);
              return false;
            }
          }
          // let system handle back button if we're on the first route
          return isFirstRouteInCurrentTab;
        },
        child: Scaffold(
          // appBar: _buildOffstageNavigatorAppBar(_currentPage)
          //     as PreferredSizeWidget,
          body: Stack(children: <Widget>[
            _buildOffstageNavigator("Home"),
            _buildOffstageNavigator("Explore"),
            _buildOffstageNavigator("Library"),
            _buildOffstageNavigator("Writer"),
            _buildOffstageNavigator("Profile"),
          ]),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Trang chủ',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Tìm kiếm',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: 'Thư viện',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.edit),
                label: 'Viết',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Hồ sơ',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: appColors.primaryBase,
            onTap: (int index) {
              _selectTab(pageKeys[index], index);
            },
            // selectedLabelStyle: Theme.of(context).textTheme.labelLarge,
            unselectedLabelStyle: const TextStyle(),
            unselectedItemColor: appColors.skyBase,
          ),
        ));
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: AppTabNavigator(
        navigatorKey: _navigatorKeys[tabItem] as GlobalKey<NavigatorState>,
        tabItem: tabItem,
      ),
    );
  }

  Widget _buildOffstageNavigatorAppBar(String tabItem) {
    return AppBarNavigator(
      navigatorKey: _appBarNavigatorKeys[tabItem] as GlobalKey<NavigatorState>,
      tabItem: tabItem,
    );
  }
}
