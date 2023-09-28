import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/feat-read/screens/comment/comment_detail_screen.dart';
import 'package:audiory_v0/models/Comment.dart';
import 'package:audiory_v0/repositories/activities_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/relative_time.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  final bool isDetail;

  const CommentCard({
    super.key,
    required this.comment,
    this.isDetail = false,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final userName = comment.user?.username ?? 'username';
    final createdTime = comment.createdDate ?? '2023-09-25T21:15:38+07:00';
    final content = comment.text;

    goToUserProfile() {
      //go to user profile
    }

    handleLikeComment(bool isLiked) {
      ActivitiesRepository.sendActivity(
        actionEntity: 'COMMENT',
        actionType: isLiked ? 'UNLIKED' : 'LIKED',
        entityId: comment.id,
      );

      // queryClient.setQueryData<(['comment', comment.chapterId], (previous){

      // });
    }

    handleOpenCommentDetail(String id) {
      showModalBottomSheet(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          )),
          useSafeArea: true,
          backgroundColor: Colors.white,
          context: context,
          builder: (context) {
            return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: CommentDetailScreen(commentId: id));
          });
    }

    return Container(
        width: double.infinity,
        child: Expanded(
          child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: goToUserProfile,
                    child: ClipRRect(
                        // borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(FALLBACK_IMG_URL,
                            width: 40.0, height: 40.0))),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: appColors.skyLighter, width: 0.5))),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      onTap: goToUserProfile,
                                      child: Text(
                                        userName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(fontSize: 15),
                                      )),
                                  Text(
                                    formatRelativeTime(createdTime),
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  )
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  content,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontSize: 16),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                              onTap: () {
                                                handleLikeComment(
                                                    comment.isLiked == true);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: Text('Thích',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color: comment
                                                                        .isLiked ==
                                                                    true
                                                                ? appColors
                                                                    .primaryBase
                                                                : appColors
                                                                    .inkLighter)),
                                              ))),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      if (!isDetail)
                                        Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                                onTap: () {
                                                  handleOpenCommentDetail(
                                                      comment.id);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  child: Text('Trả lời',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium
                                                          ?.copyWith(
                                                              fontSize: 14,
                                                              color: appColors
                                                                  .inkLighter)),
                                                ))),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Builder(builder: (context) {
                                        if (isDetail) return SizedBox();
                                        final replyCount = comment.replyCount;
                                        if (replyCount == null)
                                          return SizedBox();
                                        if (replyCount == 0) return SizedBox();
                                        return Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                                onTap: () {
                                                  handleOpenCommentDetail(
                                                      comment.id);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  child: Text(
                                                      'Xem ${replyCount} trả lời',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium
                                                          ?.copyWith(
                                                              fontSize: 14,
                                                              color: appColors
                                                                  .inkLighter)),
                                                )));
                                      }),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Text(
                                            '${comment.likeCount ?? 0}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                    color: comment.isLiked ==
                                                            true
                                                        ? appColors.primaryBase
                                                        : appColors.inkLighter,
                                                    fontSize: 14),
                                          )),
                                      Icon(
                                          comment.isLiked == true
                                              ? Icons.thumb_up_rounded
                                              : Icons.thumb_up_outlined,
                                          size: 16,
                                          color: comment.isLiked == true
                                              ? appColors.primaryBase
                                              : appColors.inkLighter),
                                    ],
                                  )
                                ],
                              )
                            ])))
              ]),
        ));
  }
}
