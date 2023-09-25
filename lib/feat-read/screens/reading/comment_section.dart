import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/feat-read/widgets/comment_card.dart';
import 'package:audiory_v0/models/enum/SnackbarType.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/repositories/comment_repository.dart';
import 'package:audiory_v0/repositories/profile_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
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
    final userInfo = useQuery(['userInfo'], () => AuthRepository().getMyInfo());

    handleSubmitComment() async {
      //CALL API
      await CommentRepository.createComment(
          chapterId: chapterId, paraId: paraId, text: controller.text);
      AppSnackBar.buildTopSnackBar(
          context, 'Bình luận thành công', null, SnackBarType.success);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '100 Bình luận',
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              height: 40,
              width: 40,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      userInfo.data?.avatarUrl ?? FALLBACK_IMG_URL),
                  fit: BoxFit.fill,
                ),
                shape: const CircleBorder(),
              ),
            ),
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
        // const CommentCard(
        //   name: 'hahaha',
        //   time: '13:14',
        //   content: 'chương này hay vl anh em',
        //   image: FALLBACK_IMG_URL,
        // ),
        // const SizedBox(height: 12),
        // const CommentCard(
        //   name: 'hahaha',
        //   time: '13:14',
        //   content: 'chương này hay vl anh em',
        //   image: FALLBACK_IMG_URL,
        // ),
        // const SizedBox(height: 12),
        // const CommentCard(
        //   name: 'hahaha',
        //   time: '13:14',
        //   content: 'chương này hay vl anh em',
        //   image: FALLBACK_IMG_URL,
        // ),
      ],
    );
  }
}
