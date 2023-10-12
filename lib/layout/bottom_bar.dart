import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBottomNavigationBar extends HookWidget {
  const AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    final selectedIndex = useState(0);
    // final router = useListenable(GoRouter.of(context).routeInformationProvider);

    void onItemTapped(int index, BuildContext context) {
      switch (index) {
        case 0:
          {
            GoRouter.of(context).push("/");
            break;
          }
        case 1:
          {
            GoRouter.of(context).push("/explore");
            break;
          }
        case 2:
          {
            GoRouter.of(context).push("/library");
            break;
          }
        case 3:
          {
            GoRouter.of(context).push("/writer");
            break;
          }
        case 4:
          {
            GoRouter.of(context).push("/profile");
            break;
          }
      }
      selectedIndex.value = index;
    }

    return BottomNavigationBar(
      backgroundColor: appColors.skyLightest,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex.value == 0 ? Icons.home_rounded : Icons.home_outlined,
          ),
          label: 'Trang chủ',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex.value == 1
                ? Icons.explore_rounded
                : Icons.explore_outlined,
          ),
          label: 'Tìm kiếm',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex.value == 2
                ? Icons.bookmark_rounded
                : Icons.bookmark_outline_rounded,
          ),
          label: 'Thư viện',
        ),
        BottomNavigationBarItem(
          icon: Icon(selectedIndex.value == 3
              ? Icons.edit_rounded
              : Icons.edit_outlined),
          label: 'Viết',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex.value == 4
                ? Icons.person_rounded
                : Icons.person_outlined,
          ),
          label: 'Hồ sơ',
        ),
      ],
      currentIndex: selectedIndex.value,
      selectedItemColor: appColors.primaryBase,
      onTap: (index) => onItemTapped(index, context),
      unselectedLabelStyle: textTheme.titleSmall,
      selectedLabelStyle:
          textTheme.titleSmall?.copyWith(color: appColors.primaryBase),
      unselectedItemColor: appColors.skyDark,
    );
  }
}
