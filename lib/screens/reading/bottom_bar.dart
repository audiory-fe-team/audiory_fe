import 'package:audiory_v0/screens/reading/reading_screen.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReadingBottomBar extends StatefulWidget {
  final Function([Color? bgColor, int? fontSize, bool? showCommentByParagraph])
      changeStyle;
  const ReadingBottomBar({super.key, required this.changeStyle});

  @override
  State<ReadingBottomBar> createState() => _ReadingBottomBarState();
}

class _ReadingBottomBarState extends State<ReadingBottomBar> {
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
      case 3:
        {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SettingModelUseHooks(
                  changeStyle: widget.changeStyle,
                );
              });
          break;
        }
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
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.format_list_bulleted),
          label: 'Chương',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Yêu thích',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: 'Bình luận',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Cài đặt',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.share),
          label: 'Chia sẻ',
        ),
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
