import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-manage-profile/widgets/wall_comment_card.dart';
import 'package:audiory_v0/feat-read/widgets/comment_card.dart';
import 'package:audiory_v0/models/wall-comment/wall_comment_model.dart';
import 'package:audiory_v0/repositories/comment_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WallCommentDetailScreen extends StatefulHookWidget {
  final String commentId;
  final WallComment? comment;
  final String? highlightId;
  final Function() callback;
  const WallCommentDetailScreen(
      {super.key,
      required this.commentId,
      this.highlightId,
      this.comment,
      required this.callback});

  static const pageSize = 10;

  @override
  State<WallCommentDetailScreen> createState() =>
      _WallCommentDetailScreenState();
}

class _WallCommentDetailScreenState extends State<WallCommentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final controller = useTextEditingController();
    final isCommenting = useState(false);
    // final comment = widget.comment;
    // final children = useState(comment?.children ?? []);

    final commentQuery = useQuery(
        ['comment', widget.commentId],
        () => CommentRepository.fetchWallCommentById(
            commentId: widget.commentId));

    handleSubmitComment() async {
      final comment = commentQuery.data;
      if (comment == null) return;
      isCommenting.value = true;
      await CommentRepository.createWallComment(
          text: controller.text, parentId: widget.commentId);
      controller.text = "";
      // AppSnackBar.buildTopSnackBar(
      //     context, 'Trả lời thành công', null, SnackBarType.success);

      FocusScope.of(context).unfocus();
      isCommenting.value = false;

      commentQuery.refetch();
      widget.callback();
    }

    return Container(
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8))), // Adjust this value
        child: Column(children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: appColors.skyBase,
                    width: 0.5,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 20),
                  Text(
                    'Chi tiết',
                    style: textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                  IconButton(
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close_outlined, size: 18)),
                ],
              )),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Builder(builder: (context) {
                    if (commentQuery.isFetching) {
                      return Skeletonizer(
                          child: ListView(children: [
                        const SizedBox(height: 24),
                        ...skeletonComments
                            .map((comment) => CommentCard(comment: comment))
                            .toList()
                      ]));
                    }
                    if (commentQuery.isError) {
                      return const Center(
                          child: Text('Không tải được bình luận. Thử lại sau'));
                    }

                    final comment = commentQuery.data;
                    if (comment == null) return const SizedBox();

                    return ListView(children: [
                      const SizedBox(height: 24),
                      WallCommentCard(
                        comment: comment,
                        isDetail: true,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.only(left: 32),
                        child: Expanded(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: (comment.children ?? [])
                                    .map((e) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: widget.highlightId == null
                                            ? WallCommentCard(
                                                comment: e,
                                                isDetail: true,
                                                onDelete: () {
                                                  widget.callback();
                                                },
                                              )
                                            : WallCommentCard(
                                                comment: e,
                                                isDetail: true,
                                                isHighlighted:
                                                    widget.highlightId == e.id,
                                                onDelete: () {
                                                  widget.callback();
                                                },
                                              )))
                                    .toList())),
                      )
                    ]);
                  }))),
          Container(
              padding: const EdgeInsets.all(6),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onTap: () {},
                      controller: controller,
                      onChanged: (value) {
                        if (value.trim() == '') {
                          'Không được để trống';
                        }
                      },
                      onSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                      },
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      decoration: InputDecoration(
                          hintText: 'Trả lời',
                          hintStyle: TextStyle(color: appColors.inkLighter),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 12, right: 12, top: 8, bottom: 8),
                          fillColor: appColors.skyLightest,
                          filled: true,
                          suffixIconConstraints: const BoxConstraints(
                            minHeight: 20,
                            minWidth: 20,
                          ),
                          suffixIcon: Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(right: 8),
                              decoration: ShapeDecoration(
                                shape: const CircleBorder(),
                                color: appColors.primaryLight,
                              ),
                              child: InkWell(
                                  onTap: () {
                                    handleSubmitComment();
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  child: const Icon(Icons.send_rounded,
                                      size: 16, color: Colors.white)))),
                    ),
                  ),
                  // const SizedBox(width: 6),
                  // Container(
                  //     decoration: ShapeDecoration(
                  //       shape: const CircleBorder(),
                  //       color: isCommenting.value
                  //           ? appColors.skyBase
                  //           : appColors.primaryBase,
                  //     ),
                  //     child: IconButton(
                  //         visualDensity:
                  //             const VisualDensity(horizontal: -4, vertical: -4),
                  //         padding: const EdgeInsets.all(10),
                  //         onPressed: () =>
                  //             isCommenting.value ? null : handleSubmitComment(),
                  //         disabledColor: appColors.skyBase,
                  //         icon: const Icon(Icons.send_rounded,
                  //             size: 16, color: Colors.white)))
                ],
              ))
        ]));
  }
}
