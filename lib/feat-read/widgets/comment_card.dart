import 'package:audiory_v0/feat-read/screens/comment/comment_detail_screen.dart';
import 'package:audiory_v0/models/Comment.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/activities_repository.dart';
import 'package:audiory_v0/repositories/comment_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/relative_time.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatefulWidget {
  final Comment comment;
  final bool isDetail;
  final bool? isHighlighted;
  final Function? onLike;
  const CommentCard(
      {Key? key,
      required this.comment,
      this.isHighlighted,
      this.isDetail = false,
      this.onLike})
      : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  late bool isLiked;

  @override
  void initState() {
    isLiked = widget.comment.isLiked ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    final comment = widget.comment;

    final userName = comment.user?.username ?? 'username';
    final createdTime = comment.createdDate ?? '2023-09-25T21:15:38+07:00';
    final content = comment.text;
    goToUserProfile() {
      //go to user profile
    }

    void handleLikeComment(bool isLiked) async {
      setState(() {
        isLiked = !isLiked;
      });
      try {
        await ActivitiesRepository.sendActivity(
          actionEntity: 'COMMENT',
          actionType: isLiked ? 'UNLIKED' : 'LIKED',
          entityId: comment.id,
        );
      } catch (error) {
        setState(() {
          isLiked = !isLiked;
        });
        AppSnackBar.buildTopSnackBar(
            context, error.toString(), null, SnackBarType.success);
      }
      if (widget.onLike != null) widget.onLike!();
    }

    void handleDeleteComment(String commentId) async {
      await CommentRepository.deleteComment(commentId: comment.id);
      await AppSnackBar.buildTopSnackBar(
          context, 'Xóa bình luận thành công', null, SnackBarType.success);
    }

    void handleReportComment(String commentId) async {
      await ActivitiesRepository.sendActivity(
        actionEntity: 'COMMENT',
        actionType: 'REPORT',
        entityId: comment.id,
      );
      AppSnackBar.buildTopSnackBar(
          context, 'Báo cáo thành công', null, SnackBarType.success);
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
          backgroundColor: appColors.background,
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
      color: widget.isHighlighted == true
          ? appColors.primaryLightest
          : Colors.transparent,
      child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: goToUserProfile,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: AppImage(
                        url: comment.user?.avatarUrl,
                        width: 40,
                        height: 40,
                        fit: BoxFit.fill))),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                style: Theme.of(context).textTheme.titleSmall,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          onTap: () {
                                            handleLikeComment(isLiked);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            child: Text('Thích',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                        fontSize: 14,
                                                        color: isLiked
                                                            ? appColors
                                                                .primaryBase
                                                            : appColors
                                                                .inkLighter)),
                                          ))),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  if (!widget.isDetail)
                                    Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                            onTap: () {
                                              handleOpenCommentDetail(
                                                  comment.id);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
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
                                    if (widget.isDetail)
                                      return const SizedBox();
                                    final replyCount = comment.children?.length;
                                    if (replyCount == null)
                                      return const SizedBox();
                                    if (replyCount == 0)
                                      return const SizedBox();
                                    return Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                            onTap: () {
                                              handleOpenCommentDetail(
                                                  comment.id);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
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
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  PopupMenuButton(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0))),
                                      child: Container(
                                          padding: const EdgeInsets.all(8),
                                          child: Icon(Icons.more_vert_rounded,
                                              size: 18,
                                              color: appColors.skyDark)),
                                      onSelected: (value) {
                                        if (value == "report") {
                                          handleReportComment(comment.id);
                                        }
                                        if (value == "delete") {
                                          handleDeleteComment(comment.id);
                                        }
                                      },
                                      itemBuilder: (context) => [
                                            PopupMenuItem(
                                                height: 36,
                                                value: 'report',
                                                child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(Icons.flag_rounded,
                                                          size: 18,
                                                          color: appColors
                                                              .inkLighter),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        'Báo cáo',
                                                        style: textTheme
                                                            .titleMedium,
                                                      )
                                                    ])),
                                            PopupMenuItem(
                                                height: 36,
                                                value: 'delete',
                                                child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .delete_outline_rounded,
                                                          size: 18,
                                                          color: appColors
                                                              .secondaryBase),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        'Xóa bình luận',
                                                        style: textTheme
                                                            .titleMedium
                                                            ?.copyWith(
                                                                color: appColors
                                                                    .secondaryBase),
                                                      )
                                                    ])),
                                          ])
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
                                                color: isLiked
                                                    ? appColors.primaryBase
                                                    : appColors.inkLighter,
                                                fontSize: 14),
                                      )),
                                  Icon(
                                      isLiked
                                          ? Icons.thumb_up_rounded
                                          : Icons.thumb_up_outlined,
                                      size: 16,
                                      color: isLiked
                                          ? appColors.primaryBase
                                          : appColors.inkLighter),
                                ],
                              )
                            ],
                          )
                        ])))
          ]),
    );
  }
}
