import 'package:audiory_v0/feat-explore/screens/explore_screen.dart';
import 'package:audiory_v0/feat-explore/screens/home_screen.dart';
import 'package:audiory_v0/feat-explore/screens/layout/home_top_bar.dart';
import 'package:audiory_v0/feat-write/screens/layout/writer_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../repositories/auth_repository.dart';
import '../theme/theme_constants.dart';
import '../widgets/custom_app_bar.dart';

class AppBarNavigator extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  const AppBarNavigator(
      {super.key, required this.navigatorKey, required this.tabItem});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final User? user = AuthRepository().currentUser;
    Widget child = HomeTopBar();

    if (tabItem == 'Home') {
      child = HomeTopBar();
    } else if (tabItem == 'Explore') {
      child = CustomAppBar(
        title: Text(
          'Khám phá',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: appColors.primaryBase),
        ),
      );
    } else if (tabItem == 'Library') {
      child = CustomAppBar(
        title: Text(
          'Thư viện',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: appColors.primaryBase),
        ),
      );
    } else if (tabItem == 'Writer') {
      print('route');
      print(ModalRoute.of(context)?.settings.name);
      child = WriterCustomAppBar();
    } else if (tabItem == 'Profile') {
      child = CustomAppBar(
        title: Text(
          'Cá nhân',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: appColors.primaryBase),
        ),
      );
    }
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}
