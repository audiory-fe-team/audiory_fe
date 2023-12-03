import 'package:audiory_v0/feat-manage-profile/screens/wall-comment/wall_comment_detail.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/wall-comment/wall_comment_model.dart';
import 'package:audiory_v0/providers/global_me_provider.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_date.dart';
import 'package:audiory_v0/utils/relative_time.dart';
import 'package:audiory_v0/widgets/cards/app_avatar_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomWallComment extends StatefulHookConsumerWidget {
  final WallComment comment;
  final Function callback;
  const CustomWallComment(
      {super.key, required this.comment, required this.callback});

  @override
  ConsumerState<CustomWallComment> createState() => _CustomWallCommentState();
}

class _CustomWallCommentState extends ConsumerState<CustomWallComment>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    final currentUserId = ref.watch(globalMeProvider)?.id;

    final WallComment comment = widget.comment;
    final Profile commentUser =
        widget.comment.user ?? Profile(id: '', username: '');
    final bool isMe = currentUserId == commentUser.id ? true : false;
    final List<WallComment> children = widget.comment.children ?? [];
    return Column(
      children: [
        Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
                color: appColors.primaryLightest.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment:
                    //     MainAxisAlignment
                    //         .spaceBetween,
                    children: [
                      Flexible(
                          flex: 1,
                          child: AppAvatarImage(
                            size: 30,
                            url: comment.user?.avatarUrl,
                          )),
                      SizedBox(
                        width: 16,
                      ),
                      Flexible(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${isMe ? 'Bạn' : commentUser.fullName} đã đăng 1 thông báo',
                                style: textTheme.titleLarge,
                              ),
                              Text(
                                formatRelativeTime(comment.createdDate),
                                style: textTheme.bodySmall
                                    ?.copyWith(color: appColors.inkLighter),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  comment.text ?? '',
                  style: textTheme?.bodyMedium
                      ?.copyWith(color: appColors.inkLighter),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: children.length != 0
                            ? Text(
                                '${children.length} trả lời',
                                style: textTheme.titleMedium
                                    ?.copyWith(color: appColors.inkLight),
                              )
                            : const SizedBox(
                                height: 0,
                              ),
                      ),
                      Flexible(
                        child: TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  useSafeArea: true,
                                  enableDrag: false,
                                  builder: (context) {
                                    return WallCommentDetailScreen(
                                      commentId: comment.id ?? '',
                                      comment: comment,
                                      highlightId: currentUserId,
                                      callback: widget.callback,
                                    );
                                  });
                            },
                            child: Text(
                              'Trả lời',
                              style: textTheme.titleMedium
                                  ?.copyWith(color: appColors.primaryBase),
                            )),
                      ),
                    ],
                  ),
                )
                // Align(
                //   alignment: Alignment
                //       .centerRight,
                //   child: IconButton(
                //       onPressed:
                //           () {},
                //       icon: comment
                //                   ?.isLiked ==
                //               true
                //           ? Icon(Icons
                //               .thumb_up_alt)
                //           : Icon(Icons
                //               .thumb_up_alt_outlined)),
                // )
              ],
            )),
        Container(
            margin: const EdgeInsets.only(left: 32),
            width: double.infinity,
            child: Column(
              children: (children ?? []).map((subComment) {
                return Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: appColors.skyLightest,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                          child: AppAvatarImage(
                        size: 30,
                        url: subComment.user?.avatarUrl,
                      )),
                      SizedBox(
                        width: 16,
                      ),
                      Flexible(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subComment.user?.fullName ?? '',
                              style: textTheme.titleLarge,
                            ),
                            Text(
                              subComment.text ?? '',
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: appColors.inkLighter),
                              textAlign: TextAlign.justify,
                            ),
                            Text(formatRelativeTime(subComment.createdDate),
                                style: textTheme.titleSmall
                                    ?.copyWith(color: appColors.inkLighter)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ))
      ],
    );
    ;
  }
}
