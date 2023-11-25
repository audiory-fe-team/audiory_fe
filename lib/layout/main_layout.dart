import 'package:audiory_v0/feat-explore/screens/explore_screen.dart';
import 'package:audiory_v0/feat-explore/screens/home_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/user_profile_screen.dart';
import 'package:audiory_v0/feat-read/screens/library/library_screen.dart';
import 'package:audiory_v0/feat-write/screens/writer_screen.dart';
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
  List<Widget> pages = [
    const HomeScreen(),
    const ExploreScreen(),
    const LibraryScreen(),
    const WriterScreen(),
    const UserProfileScreen(),
  ];
  String _currentPage = "Home";

  List<String> pageKeys = ["Home", "Explore", "Library", "Writer", "Profile"];
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

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _selectedIndex = 0;
    });
    super.initState();
  }

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
          body: IndexedStack(
            index: _selectedIndex,
            children: pages,
          ),
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
              setState(() {
                _selectedIndex = index;
              });
              // _selectTab(pageKeys[index], index);
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
}
