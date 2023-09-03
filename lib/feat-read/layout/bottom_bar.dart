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

    // void _onItemTapped(int index) {
    //   switch (index) {
    //     case 0:
    //       {
    //         break;
    //       }
    //     case 1:
    //       {
    //         //NOTE: Call api like the chapter
    //         _liked.value = !_liked.value;
    //         break;
    //       }
    //     case 2:
    //       {
    //         break;
    //       }
    //     case 3:
    //       {
    //         showModalBottomSheet(
    //             context: context,
    //             builder: (BuildContext context) {
    //               return SettingModelUseHooks(
    //                 changeStyle: changeStyle,
    //               );
    //             });
    //         break;
    //       }
    //     case 4:
    //       {
    //         break;
    //       }
    //   }
    // }

    final sharedTextStyle = Theme.of(context).textTheme.labelLarge;
    return Material(
        elevation: 10,
        child: Container(
            height: 74,
            width: double.infinity,
            child: Material(
                color: appColors.skyLightest,
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: InkWell(
                              customBorder: CircleBorder(),
                              onTap: () {},
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.format_list_bulleted),
                                  Text(
                                    'Chương',
                                    style: sharedTextStyle,
                                  )
                                ],
                              ))),
                      Expanded(
                          child: InkWell(
                              customBorder: CircleBorder(),
                              onTap: () {},
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.format_list_bulleted),
                                  Text(
                                    'Chương',
                                    style: sharedTextStyle,
                                  )
                                ],
                              ))),
                      Expanded(
                          child: InkWell(
                              customBorder: CircleBorder(),
                              onTap: () {},
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.format_list_bulleted),
                                  Text(
                                    'Chương',
                                    style: sharedTextStyle,
                                  )
                                ],
                              ))),
                      Expanded(
                          child: InkWell(
                              customBorder: CircleBorder(),
                              onTap: () {},
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.format_list_bulleted),
                                  Text(
                                    'Chương',
                                    style: sharedTextStyle,
                                  )
                                ],
                              ))),
                      Expanded(
                          child: InkWell(
                              customBorder: CircleBorder(),
                              onTap: () {},
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.format_list_bulleted),
                                  Text(
                                    'Chương',
                                    style: sharedTextStyle,
                                  )
                                ],
                              ))),
                    ]))));
  }
}
