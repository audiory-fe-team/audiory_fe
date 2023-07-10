import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/theme/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationBarApp extends StatelessWidget {
  const BottomNavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppBottomNavigationBar();
  }
}

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({super.key});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Trang chủ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: 'Tìm kiếm',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
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
      onTap: _onItemTapped,
      selectedLabelStyle: Theme.of(context).textTheme.caption2,
      unselectedLabelStyle: TextStyle(),
      unselectedItemColor: appColors.skyBase,
    );
  }
}
