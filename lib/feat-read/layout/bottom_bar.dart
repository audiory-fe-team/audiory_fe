import 'package:audiory_v0/feat-read/screens/reading_screen.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// class ReadingBottomBar extends StatefulWidget {

//   @override
//   State<ReadingBottomBar> createState() => _ReadingBottomBarState();
// }

class ReadingBottomBar extends HookWidget {
  final Function([Color? bgColor, int? fontSize, bool? showCommentByParagraph])
      changeStyle;
  const ReadingBottomBar({super.key, required this.changeStyle});

  @override
  Widget build(BuildContext context) {
    final _liked = useState(false);

    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    void _onItemTapped(int index) {
      switch (index) {
        case 0:
          {
            break;
          }
        case 1:
          {
            //NOTE: Call api like the chapter
            _liked.value = !_liked.value;
            break;
          }
        case 2:
          {
            break;
          }
        case 3:
          {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SettingModelUseHooks(
                    changeStyle: changeStyle,
                  );
                });
            break;
          }
        case 4:
          {
            break;
          }
      }
    }

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
      currentIndex: 1,
      onTap: _onItemTapped,
      selectedLabelStyle: Theme.of(context).textTheme.labelLarge,
      unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
      unselectedItemColor: appColors.skyBase,
      selectedItemColor:
          _liked.value ? appColors.primaryBase : appColors.skyBase,
      showUnselectedLabels: true,
    );
  }
}
