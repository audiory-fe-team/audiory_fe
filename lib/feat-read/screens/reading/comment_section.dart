import 'package:audiory_v0/feat-read/screens/comment/comment_screen.dart';
import 'package:audiory_v0/feat-read/widgets/comment_card.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/repositories/chapter_repository.dart';
import 'package:audiory_v0/repositories/comment_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';

class CommentSection extends HookWidget {
  final String chapterId;
  final String paraId;
  const CommentSection(
      {super.key, required this.chapterId, required this.paraId});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final controller = useTextEditingController();
    final infoQuery =
        useQuery(['userInfo'], () => AuthRepository().getMyInfo());
    final commentsQuery = useQuery(
        ['comments', 'chapter', chapterId],
        () => ChapterRepository.fetchCommentsByChapterId(
            chapterId: chapterId, offset: 0, limit: 4, sortBy: 'like_count'));

    handleSubmitComment() async {
      //CALL API
      await CommentRepository.createComment(
          chapterId: chapterId, paraId: paraId, text: controller.text);
      AppSnackBar.buildTopSnackBar(
          context, 'Bình luận thành công', null, SnackBarType.success);
      controller.text = "";
      commentsQuery.refetch();
    }

    handleOpenCommentChapter() {
      showModalBottomSheet(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          )),
          useSafeArea: true,
          backgroundColor: appColors.background,
          context: context,
          builder: (context) {
            return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: CommentScreen(chapterId: chapterId));
          });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '100 Bình luận',
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: AppImage(
                    url: infoQuery.data?.avatarUrl,
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill)),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                onTap: () {},
                controller: controller,
                onChanged: (value) {},
                onSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                },
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
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
                    fillColor: appColors.skyLightest,
                    filled: true,
                    suffixIconConstraints: const BoxConstraints(
                      minHeight: 40,
                      minWidth: 40,
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
          ]),
        ),
        const SizedBox(height: 16),
        ...(commentsQuery.data ?? []).map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CommentCard(comment: e),
            )),
        if ((commentsQuery.data ?? []).length > 3)
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                    onPressed: () {
                      handleOpenCommentChapter();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: appColors.skyLighter,
                      minimumSize: Size.zero, // Set this
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      alignment: Alignment.center,
                      // and this
                    ),
                    child: Text(
                      'Xem thêm bình luận',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: appColors.inkLight, fontSize: 12),
                    ))
              ])
      ],
    );
  }
}
