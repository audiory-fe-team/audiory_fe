import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/feat-manage-profile/screens/privacy-lists/detail_report_screen.dart';
import 'package:audiory_v0/feat-read/screens/comment/comment_detail_screen.dart';
import 'package:audiory_v0/feat-read/screens/comment/comment_screen.dart';
import 'package:audiory_v0/models/Comment.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/notification/noti_model.dart';
import 'package:audiory_v0/repositories/comment_repository.dart';
import 'package:audiory_v0/repositories/notification_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/relative_time.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class NotificationCard extends HookWidget {
  final Noti? noti;

  const NotificationCard({super.key, this.noti});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    final isRead = useState(noti?.isRead);

    handleShowComment(Comment comment) {
      showModalBottomSheet(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          )),
          useSafeArea: true,
          backgroundColor: Colors.white,
          context: context,
          builder: (context) {
            if (comment.chapterId == null) return const SizedBox();
            return comment.parentId == null
                ? CommentScreen(
                    chapterId: comment.chapterId!,
                  )
                : CommentDetailScreen(commentId: comment.parentId!);
          });
    }

    handleReadNoti() async {
      if (noti?.id == null) return;
      if (isRead.value == true) return;
      try {
        await NotificationRepostitory.updateNotiRead(noti?.id);
        isRead.value = true;
      } catch (e) {
        AppSnackBar.buildTopSnackBar(
            context,
            'Có lỗi xảy ra. Vui lòng liên hệ admin để được hỗ trợ',
            null,
            SnackBarType.error);
      }
    }

    handleTapComment(BuildContext context) async {
      final activity = noti?.activity;
      if (activity == null) return;

      if (activity.actionEntity == 'REPORT') {
        showModalBottomSheet(
            useSafeArea: true,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return DetailReportScreen(
                reportId: activity.entityId,
              );
            });
      }
      //NOTE: Entity is a story
      if (activity.actionEntity == 'STORY') {
        context.push('/story/${activity.entityId}');
      }

      if (activity.actionEntity == 'CHAPTER') {
        context.push('/story/${activity.entityId}');
      }

      //NOTE: Entity is a profile
      if (activity.actionEntity == 'USER') {
        context.push('/accountProfile/${activity.userId}');
      }

      //NOTE: Entity is a comment
      if (activity.actionEntity == 'COMMENT') {
        final comment = await CommentRepository.fetchCommentById(
            commentId: activity.entityId);

        if (activity.actionType == 'COMMENTED') {
          handleShowComment(comment);
        }
      }
    }

    return GestureDetector(
        onTap: () {
          handleReadNoti();
          handleTapComment(context);
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isRead.value == false
                ? appColors.skyLightest
                : Colors.transparent,
          ),
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: ShapeDecoration(
                  color: appColors.primaryLightest,
                  image: DecorationImage(
                    image: NetworkImage(
                      noti?.activity.user?.avatarUrl ?? FALLBACK_IMG_URL,
                    ),
                    onError: (exception, stackTrace) =>
                        Image.network(FALLBACK_BACKGROUND_URL),
                    fit: BoxFit.fill,
                  ),
                  shape: const CircleBorder(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          noti?.content ?? 'Ẩn danh',
                          style: textTheme.titleMedium?.copyWith(fontSize: 13),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        if (noti?.activity.createdDate != null)
                          Text(
                            formatRelativeTime(
                                noti?.activity.createdDate ?? ''),
                            style: textTheme.titleSmall?.copyWith(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                color: appColors.inkLight),
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    )),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Container(
              //   width: 45,
              //   height: 60,
              //   decoration: BoxDecoration(
              //     color: appColors.primaryLightest,
              //     image: DecorationImage(
              //       image: NetworkImage(
              //           noti?.activity.user?.avatarUrl ?? FALLBACK_IMG_URL),
              //       fit: BoxFit.fill,
              //     ),
              //     borderRadius: BorderRadius.circular(4),
              //   ),
              // ),
              // const SizedBox(width: 6),
              if (isRead.value != true)
                Column(children: [
                  Container(
                    height: 8,
                    width: 8,
                    decoration: ShapeDecoration(
                        color: appColors.primaryBase,
                        shape: const CircleBorder()),
                  )
                ])
            ],
          ),
        ));
  }
}
