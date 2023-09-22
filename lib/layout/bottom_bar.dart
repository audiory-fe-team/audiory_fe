import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class AppBottomNavigationBar extends HookWidget {
  const AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final selectedIndex = useState(0);
    // final router = useListenable(GoRouter.of(context).routeInformationProvider);

    void onItemTapped(int index, BuildContext context) {
      switch (index) {
        case 0:
          {
            GoRouter.of(context).go("/");
            break;
          }
        case 1:
          {
            GoRouter.of(context).go("/explore");
            break;
          }
        case 2:
          {
            GoRouter.of(context).go("/library");
            break;
          }
        case 3:
          {
            GoRouter.of(context).go("/writer");
            break;
          }
        case 4:
          {
            GoRouter.of(context).go("/profile");
            break;
          }
      }
      selectedIndex.value = index;
    }

    return BottomNavigationBar(
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
      currentIndex: selectedIndex.value,
      selectedItemColor: appColors.primaryBase,
      onTap: (index) => onItemTapped(index, context),
      unselectedLabelStyle: const TextStyle(),
      unselectedItemColor: appColors.skyBase,
    );
  }
}
