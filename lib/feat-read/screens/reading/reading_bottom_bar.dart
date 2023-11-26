import 'package:audiory_v0/feat-read/screens/comment/comment_screen.dart';
import 'package:audiory_v0/feat-read/screens/reading/share_link_sheet.dart';
import 'package:audiory_v0/feat-read/screens/reading/setting_modal.dart';
import 'package:audiory_v0/repositories/activities_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ReadingBottomBar extends HookWidget {
  final String chapterId;
  final String storyId;
  final Function() onChangeStyle;
  final bool isVoted;
  const ReadingBottomBar({
    super.key,
    required this.onChangeStyle,
    required this.chapterId,
    required this.storyId,
    this.isVoted = false,
  });
  static const iconSize = 20.0;
  @override
  Widget build(BuildContext context) {
    final liked = useState(isVoted);
    final settingOpen = useState(false);
    final AppColors? appColors = Theme.of(context).extension<AppColors>();

    void handleOpenChapter() {
      Scaffold.of(context).openDrawer();
    }

    void handleToggleLike() async {
      //NOTE:Call api like
      if (!liked.value) {
        await ActivitiesRepository.sendActivity(
            actionEntity: 'CHAPTER', actionType: 'VOTED', entityId: chapterId);
        // AppSnackBar.buildTopSnackBar(
        //     context, 'Đã thích chương', null, SnackBarType.success);
      } else {
        await ActivitiesRepository.sendActivity(
            actionEntity: 'CHAPTER',
            actionType: 'UNVOTED',
            entityId: chapterId);
      }
      liked.value = !liked.value;
    }

    void handleOpenComment() {
      //NOTE: Navigate to comment of chapter page
      showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: appColors?.background,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          )),
          useSafeArea: true,
          context: context,
          builder: (context) {
            return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: CommentScreen(chapterId: chapterId));
          });
    }

    void handleOpenSetting() {
      settingOpen.value = true;
      final _scaffoldKey = new GlobalKey<ScaffoldState>();

      showModalBottomSheet(
          isScrollControlled: true,
          useSafeArea: true,
          useRootNavigator: true,
          backgroundColor: appColors?.background,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          )),
          context: context,
          builder: (BuildContext context) {
            return Scaffold(
                key: _scaffoldKey,
                body: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: SettingModel(
                      onChangeStyle: onChangeStyle,
                    )));
          }).whenComplete(() {
        settingOpen.value = false;
      });
    }

    handleShare() async {
      showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: appColors?.background,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          )),
          useSafeArea: true,
          context: context,
          builder: (_) {
            return ShareLinkSheet(
                appRoutePath: '/story/$storyId/chapter/$chapterId');
          });
    }

    final sharedTextStyle = Theme.of(context).textTheme.titleSmall;
    return Container(
        height: 58,
        width: double.infinity,
        color: appColors?.background,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: InkWell(
                      overlayColor:
                          MaterialStatePropertyAll(appColors?.primaryLightest),
                      customBorder: const CircleBorder(),
                      onTap: () {
                        handleOpenChapter();
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.format_list_bulleted_rounded,
                            color: appColors?.skyBase,
                          ),
                          Text(
                            'Chương',
                            style: sharedTextStyle?.copyWith(
                                color: appColors?.skyBase),
                          )
                        ],
                      ))),
              Expanded(
                  child: InkWell(
                      overlayColor:
                          MaterialStatePropertyAll(appColors?.primaryLightest),
                      customBorder: const CircleBorder(),
                      onTap: () {
                        handleToggleLike();
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                              liked.value
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_outline,
                              color: liked.value
                                  ? appColors?.secondaryBase
                                  : appColors?.skyBase,
                              size: iconSize),
                          Text(
                            'Bình chọn',
                            style: sharedTextStyle?.copyWith(
                                color: liked.value
                                    ? appColors?.secondaryBase
                                    : appColors?.skyBase),
                          )
                        ],
                      ))),
              Expanded(
                  child: InkWell(
                      overlayColor:
                          MaterialStatePropertyAll(appColors?.primaryLightest),
                      customBorder: const CircleBorder(),
                      onTap: handleOpenComment,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.chat_bubble_outline_rounded,
                              color: appColors?.skyBase, size: iconSize),
                          Text(
                            'Bình luận',
                            style: sharedTextStyle?.copyWith(
                                color: appColors?.skyBase),
                          )
                        ],
                      ))),
              Expanded(
                  child: InkWell(
                      overlayColor:
                          MaterialStatePropertyAll(appColors?.primaryLightest),
                      customBorder: const CircleBorder(),
                      onTap: () {
                        handleOpenSetting();
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.settings_rounded,
                              color: settingOpen.value
                                  ? appColors?.primaryBase
                                  : appColors?.skyBase,
                              size: iconSize),
                          Text(
                            'Cài đặt',
                            style: sharedTextStyle?.copyWith(
                                color: settingOpen.value
                                    ? appColors?.primaryBase
                                    : appColors?.skyBase),
                          )
                        ],
                      ))),
              Expanded(
                  child: InkWell(
                      overlayColor:
                          MaterialStatePropertyAll(appColors?.primaryLightest),
                      customBorder: const CircleBorder(),
                      onTap: () {
                        handleShare();
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.share,
                              color: appColors?.skyBase, size: iconSize),
                          Text(
                            'Chia sẻ',
                            style: sharedTextStyle?.copyWith(
                                color: appColors?.skyBase),
                          )
                        ],
                      ))),
            ]));
  }
}
