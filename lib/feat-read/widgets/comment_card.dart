import 'package:audiory_v0/feat-read/screens/comment/comment_detail_screen.dart';
import 'package:audiory_v0/models/Comment.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/activities_repository.dart';
import 'package:audiory_v0/repositories/comment_repository.dart';
import 'package:audiory_v0/repositories/report_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/relative_time.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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
  late bool isDeleted;

  @override
  void initState() {
    setState(() {
      isLiked = widget.comment.isLiked ?? false;
      isDeleted = false;
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormBuilderState>();

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

    void handleLikeComment() async {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tạo thành công'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {
        isLiked = !isLiked;
      });
      try {
        await ActivitiesRepository.sendActivity(
          actionEntity: 'COMMENT',
          actionType: !isLiked ? 'UNLIKED' : 'LIKED',
          entityId: comment.id,
        );
      } catch (error) {
        setState(() {
          isLiked = !isLiked;
        });
        AppSnackBar.buildTopSnackBar(
            context, error.toString(), null, SnackBarType.error);
      }
      if (widget.onLike != null) widget.onLike!();
    }

    void handleDeleteComment(String commentId) async {
      try {
        await CommentRepository.deleteComment(commentId: comment.id);
        await AppSnackBar.buildTopSnackBar(
            context, 'Xóa bình luận thành công', null, SnackBarType.success);
        setState(() {
          isDeleted = true;
        });
      } catch (error) {
        await AppSnackBar.buildTopSnackBar(
            context, 'Không thể xóa bình luận', null, SnackBarType.error);
      }
    }

    handleCreateReport() async {
      Map<String, String> body = {};

      const storage = FlutterSecureStorage();
      final jwtToken = await storage.read(key: 'jwt');
      final userId = JwtDecoder.decode(jwtToken as String)['user_id'];
      body['user_id'] = userId;
      body['title'] = _formKey.currentState?.fields['title']?.value;
      body['description'] = _formKey.currentState?.fields['description']?.value;
      body['report_type'] = 'COMMENT';
      body['reported_id'] = comment.id;
      try {
        await ReportRepository.addReport(
            body, _formKey.currentState?.fields['photo']?.value);

        await AppSnackBar.buildTopSnackBar(
            context, 'Tạo thành công', null, SnackBarType.success);
      } catch (error) {
        // ignore: use_build_context_synchronously
        AppSnackBar.buildTopSnackBar(
            context, 'Tạo thất bại', null, SnackBarType.error);
      }
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

    if (isDeleted) {
      return Text('Bình luận đã bị xóa', style: textTheme.titleSmall);
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
                                            handleLikeComment();
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
                                          final size =
                                              MediaQuery.of(context).size;

                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              scrollable: true,
                                              title: Column(children: [
                                                Text(
                                                  'Báo cáo  bình luận này',
                                                  style: textTheme.titleLarge
                                                      ?.copyWith(
                                                          color: appColors
                                                              .inkDarkest),
                                                ),
                                                // Text(
                                                //   'Giúp chúng tôi điền vài thông tin nhé',
                                                //   style: textTheme.bodyMedium
                                                //       ?.copyWith(
                                                //           color: appColors
                                                //               ?.inkLight),
                                                //   textAlign: TextAlign.center,
                                                // )
                                              ]),
                                              content: SizedBox(
                                                width: size.width / 2,
                                                // height: size.height / 2.8,
                                                child: FormBuilder(
                                                  key: _formKey,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        width: size.width / 4,
                                                        child: FormBuilderImagePicker(
                                                            previewAutoSizeWidth:
                                                                true,
                                                            maxImages: 1,
                                                            backgroundColor:
                                                                appColors
                                                                    .skyLightest,
                                                            iconColor: appColors
                                                                .primaryBase,
                                                            decoration:
                                                                const InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none),
                                                            name: 'photo'),
                                                      ),
                                                      AppTextInputField(
                                                        sizeBoxHeight: 0,
                                                        hintText:
                                                            'Đặt tiêu đề cho báo cáo',
                                                        name: 'title',
                                                        validator:
                                                            FormBuilderValidators
                                                                .required(
                                                                    errorText:
                                                                        'Không được để trống'),
                                                      ),
                                                      const SizedBox(
                                                          height: 12),
                                                      AppTextInputField(
                                                        isTextArea: true,
                                                        maxLengthCharacters:
                                                            200,
                                                        minLines: 2,
                                                        maxLines: 5,
                                                        hintText:
                                                            'Ví dụ: Bình luận này có nội dung kích động',
                                                        name: 'description',
                                                        validator:
                                                            FormBuilderValidators
                                                                .required(
                                                                    errorText:
                                                                        'Không được để trống'),
                                                      ),
                                                      const SizedBox(
                                                          height: 12),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                context.pop();
                                                              },
                                                              child: Text(
                                                                'Hủy',
                                                                style: textTheme
                                                                    .titleMedium,
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                //check if input validate
                                                                final isValid = _formKey
                                                                    .currentState
                                                                    ?.validate();

                                                                if (isValid !=
                                                                        null &&
                                                                    isValid) {
                                                                  _formKey
                                                                      .currentState
                                                                      ?.save();
                                                                  context.pop();
                                                                  handleCreateReport();
                                                                }
                                                                // context.pop();
                                                              },
                                                              child: Text(
                                                                'Tạo',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: textTheme.titleMedium?.copyWith(
                                                                    color: _formKey.currentState?.validate() ==
                                                                            true
                                                                        ? appColors
                                                                            ?.primaryBase
                                                                        : appColors
                                                                            ?.inkLighter),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
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
