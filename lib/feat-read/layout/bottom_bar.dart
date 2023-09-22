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
    final liked = useState(false);
    final settingOpen = useState(false);
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    void handleOpenChapter() {}
    void handleToggleLike() {
      //NOTE:Call api like
      liked.value = !liked.value;
    }

    void handleOpenComment() {
      //NOTE: Navigate to comment of chapter page
    }

    void handleOpenSetting() {
      settingOpen.value = true;
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SettingModel(
              changeStyle: changeStyle,
            );
          }).whenComplete(() {
        settingOpen.value = false;
      });
    }

    final sharedTextStyle = Theme.of(context).textTheme.labelLarge;
    return Material(
        elevation: 10,
        child: SizedBox(
            height: 65,
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
                              overlayColor: MaterialStatePropertyAll(
                                  appColors.primaryLightest),
                              customBorder: CircleBorder(),
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.format_list_bulleted,
                                    color: appColors.skyBase,
                                  ),
                                  Text(
                                    'Chương',
                                    style: sharedTextStyle?.copyWith(
                                        color: appColors.skyBase),
                                  )
                                ],
                              ))),
                      Expanded(
                          child: InkWell(
                              overlayColor: MaterialStatePropertyAll(
                                  appColors.primaryLightest),
                              customBorder: CircleBorder(),
                              onTap: () {},
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.favorite,
                                      color: liked.value
                                          ? appColors.primaryBase
                                          : appColors.skyBase),
                                  Text(
                                    'Bình chọn',
                                    style: sharedTextStyle?.copyWith(
                                        color: liked.value
                                            ? appColors.primaryBase
                                            : appColors.skyBase),
                                  )
                                ],
                              ))),
                      Expanded(
                          child: InkWell(
                              overlayColor: MaterialStatePropertyAll(
                                  appColors.primaryLightest),
                              customBorder: CircleBorder(),
                              onTap: () {},
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.chat_bubble_rounded,
                                    color: appColors.skyBase,
                                  ),
                                  Text(
                                    'Bình luận',
                                    style: sharedTextStyle?.copyWith(
                                        color: appColors.skyBase),
                                  )
                                ],
                              ))),
                      Expanded(
                          child: InkWell(
                              overlayColor: MaterialStatePropertyAll(
                                  appColors.primaryLightest),
                              customBorder: CircleBorder(),
                              onTap: () {
                                handleOpenSetting();
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.settings,
                                    color: settingOpen.value
                                        ? appColors.primaryBase
                                        : appColors.skyBase,
                                  ),
                                  Text(
                                    'Cài đặt',
                                    style: sharedTextStyle?.copyWith(
                                        color: settingOpen.value
                                            ? appColors.primaryBase
                                            : appColors.skyBase),
                                  )
                                ],
                              ))),
                      Expanded(
                          child: InkWell(
                              overlayColor: MaterialStatePropertyAll(
                                  appColors.primaryLightest),
                              customBorder: CircleBorder(),
                              onTap: () {},
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.share,
                                    color: appColors.skyBase,
                                  ),
                                  Text(
                                    'Chia sẻ',
                                    style: sharedTextStyle?.copyWith(
                                        color: appColors.skyBase),
                                  )
                                ],
                              ))),
                    ]))));
  }
}
