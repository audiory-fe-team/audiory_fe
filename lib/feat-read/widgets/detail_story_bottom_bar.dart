import 'package:flutter/material.dart';

import '../../theme/theme_constants.dart';

class DetailStoryBottomBar extends StatefulWidget {
  const DetailStoryBottomBar({super.key});

  @override
  State<DetailStoryBottomBar> createState() => DetailStoryBottomBarState();
}

class DetailStoryBottomBarState extends State<DetailStoryBottomBar> {
  bool _liked = false;

  void _onItemTapped(int index) {
    switch (index) {
      // case 0:
      //   {
      //     GoRouter.of(context).go("/");
      //     break;
      //   }
      case 1:
        {
          setState(() {
            _liked = !_liked;
          });
          break;
        }
      // case 2:
      //   {
      //     GoRouter.of(context).go("/library");
      //     break;
      //   }
      // case 3:
      //   {
      //     GoRouter.of(context).go("/writer");
      //     break;
      //   }
      // case 4:
      //   {
      //     GoRouter.of(context).go("/profile");
      //     break;
      //   }
    }
    // setState(() {
    //   _selectedIndex = index;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Yêu thích',
        ),
        BottomNavigationBarItem(
          icon: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              height: 56,
              width: MediaQuery.of(context).size.width / 2,
              child: Icon(Icons.bookmark)),
          label: 'Lưu trữ',
        ),
        BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: appColors.primaryBase,
                shape: BoxShape.rectangle,
              ),
              height: 56,
              width: MediaQuery.of(context).size.width / 2,
              child: Center(
                child: Text(
                  'Đọc',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: appColors.skyLightest),
                ),
              ),
            ),
            label: ''),
      ],
      currentIndex: _liked ? 1 : 0,
      onTap: _onItemTapped,
      selectedLabelStyle: Theme.of(context).textTheme.labelLarge,
      unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
      unselectedItemColor: appColors.skyBase,
      selectedItemColor: appColors.primaryBase,
      showUnselectedLabels: true,
    );
  }
}
