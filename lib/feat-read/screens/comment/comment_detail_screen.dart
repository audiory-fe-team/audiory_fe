import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-read/widgets/comment_card.dart';
import 'package:audiory_v0/repositories/comment_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CommentDetailScreen extends HookWidget {
  final String commentId;
  final String? highlightId;
  const CommentDetailScreen(
      {super.key, required this.commentId, this.highlightId});

  static const pageSize = 10;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final controller = useTextEditingController();
    final isCommenting = useState(false);

    final commentQuery = useQuery(['comment', commentId],
        () => CommentRepository.fetchCommentById(commentId: commentId));

    handleSubmitComment() async {
      final comment = commentQuery.data;
      if (comment == null) return;
      isCommenting.value = true;
      await CommentRepository.createComment(
          chapterId: comment.chapterId,
          paraId: comment.paragraphId,
          text: controller.text,
          parentId: commentId);
      controller.text = "";
      // AppSnackBar.buildTopSnackBar(
      //     context, 'Trả lời thành công', null, SnackBarType.success);
      FocusScope.of(context).unfocus();
      isCommenting.value = false;
      commentQuery.refetch();
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
                    'Bình luận chi tiết',
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
                  child: RefreshIndicator(onRefresh: () async {
                    commentQuery.refetch();
                  }, child: Builder(builder: (context) {
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
                      CommentCard(
                        comment: comment,
                        isDetail: true,
                        onLike: () => commentQuery.refetch(),
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
                                        child: highlightId == null
                                            ? CommentCard(
                                                comment: e, isDetail: true)
                                            : CommentCard(
                                                comment: e,
                                                isDetail: true,
                                                isHighlighted:
                                                    highlightId == e.id)))
                                    .toList())),
                      )
                    ]);
                  })))),
          Container(
              padding: const EdgeInsets.all(6),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onTap: () {},
                      controller: controller,
                      onChanged: (value) {},
                      onSubmitted: (value) {},
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText:
                            'Trả lời ${commentQuery.data?.user?.username}',
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
                        fillColor: appColors.skyLighter,
                        filled: true,
                        suffixIconConstraints: const BoxConstraints(
                          minHeight: 40,
                          minWidth: 40,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                      decoration: ShapeDecoration(
                        shape: const CircleBorder(),
                        color: isCommenting.value
                            ? appColors.skyBase
                            : appColors.primaryBase,
                      ),
                      child: IconButton(
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          padding: const EdgeInsets.all(10),
                          onPressed: () =>
                              isCommenting.value ? null : handleSubmitComment(),
                          disabledColor: appColors.skyBase,
                          icon: const Icon(Icons.send_rounded,
                              size: 16, color: Colors.white)))
                ],
              ))
        ]));
  }
}
