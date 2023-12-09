import 'package:audiory_v0/feat-read/screens/reading/share_link_sheet.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/report_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailStoryTopBar extends StatelessWidget implements PreferredSizeWidget {
  final Story? story;

  const DetailStoryTopBar({super.key, required this.story});

  @override
  Size get preferredSize => const Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    final AppColors? appColors = Theme.of(context).extension<AppColors>();
    final textTheme = Theme.of(context).textTheme;

    handleShare() {
      if (story == null) return;

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
            return ShareLinkSheet(appRoutePath: '/story/${story!.id}');
          });
    }

    ;
    handleReport() {
      if (story == null) return;
      showDialog(
          context: context,
          builder: (context) =>
              ReportDialog(reportType: 'STORY', reportId: story!.id));
    }

    return SafeArea(
        child: Container(
            height: 58,
            width: double.infinity,
            // padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 172, 136, 28),
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (GoRouter.of(context).canPop()) {
                      GoRouter.of(context).pop();
                    }
                  },
                  icon: Icon(Icons.arrow_back,
                      size: 24, color: appColors?.inkBase),
                ),
                const SizedBox(width: 4),
                Expanded(
                    child: Text(story?.title ?? '',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineSmall)),
                PopupMenuButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.more_vert_rounded, size: 24)),
                    onSelected: (value) {
                      if (value == "share") {
                        handleShare();
                      }
                      if (value == "report") {
                        handleReport();
                      }
                    },
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              height: 40,
                              value: 'share',
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.share_rounded,
                                        size: 18, color: appColors?.inkBase),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Chia sẻ',
                                      style: textTheme.titleMedium,
                                    )
                                  ])),
                          PopupMenuItem(
                              height: 40,
                              value: 'report',
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.report_rounded,
                                        size: 18, color: appColors?.inkBase),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Báo cáo',
                                      style: textTheme.titleMedium,
                                    )
                                  ])),
                        ])
              ],
            )));
  }
}
