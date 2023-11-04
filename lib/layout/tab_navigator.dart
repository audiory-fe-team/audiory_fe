import 'package:audiory_v0/feat-explore/screens/home_screen.dart';
import 'package:audiory_v0/feat-write/screens/writer_screen.dart';
import 'package:flutter/material.dart';
import 'package:audiory_v0/feat-read/screens/library/library_screen.dart';

import '../feat-manage-profile/screens/user_profile_screen.dart';

class AppTabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  const AppTabNavigator(
      {super.key, required this.navigatorKey, required this.tabItem});

  @override
  Widget build(BuildContext context) {
    Widget child = const HomeScreen();

    if (tabItem == 'Home') {
      child = const HomeScreen();
    } else if (tabItem == 'Explore')
      child = WriterScreen();
    else if (tabItem == 'Library') {
      child = const LibraryScreen();
    } else if (tabItem == 'Writer')
      child = const LibraryScreen();
    else if (tabItem == 'Profile') {
      child = const UserProfileScreen();
    }
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
