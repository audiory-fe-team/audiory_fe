import 'package:audiory_v0/feat-read/widgets/comment_card.dart';
import 'package:audiory_v0/models/Comment.dart';
import 'package:audiory_v0/repositories/chapter_repository.dart';
import 'package:audiory_v0/repositories/comment_repository.dart';
import 'package:audiory_v0/repositories/para_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/use_paging_controller.dart';
import 'package:audiory_v0/widgets/paginators/infinite_scroll_paginator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CommentScreen extends HookWidget {
  final String chapterId;
  final String? paraId;
  const CommentScreen({super.key, required this.chapterId, this.paraId});

  static const pageSize = 10;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final isCommenting = useState(false);

    final controller = useTextEditingController();
    final chapterQuery = useQuery(
      ['chapter', chapterId],
      () => ChapterRepository().fetchChapterDetail(chapterId),
    );
    final sortBy = useState('like_count');

    final PagingController<int, Comment> commentsPagingController =
        usePagingController(
            firstPageKey: 0,
            onPageRequest: (int pageKey,
                PagingController<int, Comment> pagingController) async {
              try {
                List<Comment> newItems = [];
                if (paraId != null) {
                  newItems = await ParaRepository.fetchCommentsByParaId(
                      paraId: paraId!,
                      offset: pageKey,
                      limit: pageSize,
                      sortBy: sortBy.value);
                } else {
                  newItems = await ChapterRepository.fetchCommentsByChapterId(
                      chapterId: chapterId,
                      offset: pageKey,
                      limit: pageSize,
                      sortBy: sortBy.value);
                }

                final isLastPage = newItems.length < pageSize;
                if (isLastPage) {
                  pagingController.appendLastPage(newItems);
                } else {
                  final nextPageKey = pageKey + newItems.length;
                  pagingController.appendPage(newItems, nextPageKey);
                }
              } catch (error) {
                pagingController.error = error;
              }
            });

    handleSubmitComment() async {
      //CALL API
      final paragraphs = chapterQuery.data?.paragraphs;
      if (paragraphs == null || paragraphs.isEmpty) {
        return;
      }
      isCommenting.value = true;
      final response = await CommentRepository.createComment(
          chapterId: chapterId,
          paraId: paraId ?? paragraphs[paragraphs.length - 1].id,
          text: controller.text);
      isCommenting.value = false;

      controller.text = "";
      commentsPagingController.appendLastPage([response]);
      // commentsPagingController.refresh();
    }

    return Column(mainAxisSize: MainAxisSize.min, children: [
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
                'Bình luận ${paraId == null ? 'chương' : 'đoạn'}',
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
              child: RefreshIndicator(
                  onRefresh: () async {
                    commentsPagingController.refresh();
                  },
                  child: AppInfiniteScrollList(
                    controller: commentsPagingController,
                    noItemsFoundIndicatorBuilder: (context) {
                      return Center(
                          child: Column(children: [
                        Icon(Icons.connect_without_contact_rounded,
                            size: 36, color: appColors.primaryBase),
                        const Text(
                          'Chưa có bình luận.\n Hãy là người đầu tiên bắt đầu cuộc trò chuyện!',
                          textAlign: TextAlign.center,
                        )
                      ]));
                    },
                    itemBuilder: (context, item, index) => Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: CommentCard(
                          comment: item,
                        )),
                    topItems: <Widget>[
                      const SizedBox(height: 12),
                      IntrinsicHeight(
                          child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Xếp theo:',
                              style:
                                  textTheme.titleSmall?.copyWith(fontSize: 14)),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              if (sortBy.value != 'like_count') {
                                sortBy.value = 'like_count';
                                commentsPagingController.refresh();
                              }
                            },
                            child: Text(
                              'Hot',
                              style: textTheme.titleSmall?.copyWith(
                                  fontFamily:
                                      GoogleFonts.sourceSansPro().fontFamily,
                                  fontWeight: sortBy.value == "like_count"
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  fontSize: 14,
                                  color: sortBy.value == "like_count"
                                      ? appColors.primaryBase
                                      : appColors.inkBase),
                            ),
                          ),
                          const SizedBox(width: 6),
                          VerticalDivider(
                            width: 2,
                            color: appColors.inkBase,
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                              onTap: () {
                                if (sortBy.value == 'like_count') {
                                  sortBy.value = 'created_date';
                                  commentsPagingController.refresh();
                                }
                              },
                              child: Text(
                                'Mới',
                                style: textTheme.titleSmall?.copyWith(
                                    fontFamily:
                                        GoogleFonts.sourceSansPro().fontFamily,
                                    fontWeight: !(sortBy.value == "like_count")
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    fontSize: 14,
                                    color: !(sortBy.value == "like_count")
                                        ? appColors.primaryBase
                                        : appColors.inkBase),
                              ))
                        ],
                      )),
                      const SizedBox(height: 12)
                    ],
                  )))),
      Container(
          padding: const EdgeInsets.all(6),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onTap: () {},
                  controller: controller,
                  onChanged: (value) {},
                  onSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                  },
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Bình luận gì đó',
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
    ]);
  }
}
