import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/feat-read/screens/comment/comment_detail_screen.dart';
import 'package:audiory_v0/feat-read/screens/comment/comment_screen.dart';
import 'package:audiory_v0/models/Comment.dart';
import 'package:audiory_v0/models/notification/noti_model.dart';
import 'package:audiory_v0/repositories/comment_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/relative_time.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationCard extends StatelessWidget {
  final Noti? noti;

  const NotificationCard({super.key, this.noti});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

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
            return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: comment.parentId == null
                    ? CommentScreen(
                        chapterId: comment.chapterId,
                      )
                    : CommentDetailScreen(commentId: comment.parentId!));
          });
    }

    handleTapComment(BuildContext context) async {
      final activity = noti?.activity;
      if (activity == null) return;

      //NOTE: Entity is a story
      if (activity.actionEntity == 'STORY') {
        print('/story/${activity.entityId}');
        context.go('/story/${activity.entityId}');
      }

      if (activity.actionEntity == 'CHAPTER') {
        context.go('/story/${activity.entityId}');
      }

      //NOTE: Entity is a profile
      if (activity.actionEntity == 'USER') {
        context.push('/profile/${activity.entityId}');
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
          handleTapComment(context);
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: noti?.isRead == false
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
