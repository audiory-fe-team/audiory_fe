import 'dart:io';

import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/models/reading-list/reading_list_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/app_img_picker.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class ReadingListCard extends StatefulWidget {
  final ReadingList readingList;
  final dynamic Function(String) onDeleteReadingList;
  final dynamic Function(String) onPublishHandler;
  final dynamic Function(String, String, dynamic) onEditHandler;
  const ReadingListCard(
      {super.key,
      required this.readingList,
      required this.onDeleteReadingList,
      required this.onPublishHandler,
      required this.onEditHandler});

  @override
  State<ReadingListCard> createState() => _ReadingListCardState();
}

class _ReadingListCardState extends State<ReadingListCard> {
  final _formKey = GlobalKey<FormBuilderState>();
  File? selectImg;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    String setDefaultCoverUrl() {
      String initCoverUrl = FALLBACK_IMG_URL;

      if (widget.readingList.coverUrl?.trim() != '') {
        initCoverUrl = widget.readingList.coverUrl as String;
      } else if (widget.readingList.stories!.isNotEmpty) {
        initCoverUrl =
            widget.readingList.stories?[0].coverUrl ?? FALLBACK_IMG_URL;
      }
      return initCoverUrl;
    }

    final coverUrl = setDefaultCoverUrl();
    final readingListId = widget.readingList.id;
    final title = widget.readingList.name ?? 'Tiêu đề truyện';

    final isPrivate = widget.readingList.isPrivate ?? false;

    handleEdit() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          scrollable: true,
          title: Column(children: [
            Text(
              'Sửa một danh sách đọc',
              style:
                  textTheme.titleLarge?.copyWith(color: appColors.inkDarkest),
            ),
            Text(
              'Đặt tên cho danh sách đọc của bạn',
              style: textTheme.bodyMedium?.copyWith(color: appColors.inkLight),
            )
          ]),
          content: SizedBox(
            width: size.width / 2,
            height: size.height / 2.7,
            child: FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppImagePicker(
                    callback: (img) {
                      setState(() {
                        selectImg = File(img.path);
                      });
                    },
                    width: size.width / 4,
                    height: 145,
                    initialUrl: widget.readingList.coverUrl?.trim() == ''
                        ? ''
                        : widget.readingList.coverUrl,
                  ),
                  SizedBox(
                    height: 70,
                    child: AppTextInputField(
                      initialValue: title,
                      hintText: 'Ví dụ: Truyện trinh thám hay',
                      name: 'name',
                      validator: FormBuilderValidators.required(
                          errorText: 'Không được để trống'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 100,
                            child: GestureDetector(
                              onTap: () {
                                context.pop();
                              },
                              child: Text(
                                'Hủy',
                                style: textTheme.titleMedium,
                              ),
                            )),
                        SizedBox(
                            width: 100,
                            child: GestureDetector(
                              onTap: () {
                                //check if input validate
                                final isValid =
                                    _formKey.currentState?.validate();

                                if (isValid != null && isValid) {
                                  _formKey.currentState?.save();
                                  context.pop();
                                  widget.onEditHandler(
                                      readingListId,
                                      _formKey
                                          .currentState?.fields['name']?.value,
                                      selectImg);
                                }
                                // context.pop();
                              },
                              child: Text(
                                'Sửa',
                                textAlign: TextAlign.end,
                                style: textTheme.titleMedium?.copyWith(
                                    color: _formKey.currentState?.validate() ==
                                            true
                                        ? appColors.primaryBase
                                        : appColors.inkLighter),
                              ),
                            ))
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

    handleDelete() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          icon: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: appColors.secondaryBase,
            ),
            child: Icon(
              Icons.delete,
              color: appColors.skyLightest,
            ),
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          scrollable: true,
          title: Column(children: [
            Text(
              'Xóa danh sách đọc',
              style:
                  textTheme.titleLarge?.copyWith(color: appColors.inkDarkest),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Bạn có chắc muốn xóa danh sách "$title"',
                maxLines: 2,
                style:
                    textTheme.bodyMedium?.copyWith(color: appColors.inkLight),
              ),
            )
          ]),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            GestureDetector(
              onTap: () async {
                widget.onDeleteReadingList(readingListId);
              },
              child: Text(
                'Xóa danh sách',
                style: textTheme.headlineSmall
                    ?.copyWith(color: appColors.secondaryBase),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Text(
                  'Hủy',
                  style: textTheme.headlineSmall,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
        onTap: () {
          GoRouter.of(context).push("/library/reading-list/$readingListId",
              extra: {'name': title});
        },
        child: Container(
          width: double.infinity,
          height: 120,
          decoration: ShapeDecoration(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Container(
                    //   width: 85,
                    //   height: 120,
                    //   decoration: BoxDecoration(
                    //     color: appColors.primaryLightest,
                    //     image: DecorationImage(
                    //       image: NetworkImage(coverUrl),
                    //       fit: BoxFit.fill,
                    //     ),
                    //   ),
                    // ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: AppImage(
                          url: coverUrl,
                          width: 85,
                          height: 120,
                        ))
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  title,
                                  maxLines: 2,
                                  style: textTheme.titleMedium?.merge(
                                      const TextStyle(
                                          overflow: TextOverflow.ellipsis)),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                      isPrivate
                                          ? Icons.lock_rounded
                                          : Icons.public_rounded,
                                      size: 14,
                                      color: appColors.inkBase),
                                  const SizedBox(width: 2),
                                  SizedBox(
                                      width: 140,
                                      child: Text(
                                          isPrivate ? 'Riêng tư' : 'Công khai',
                                          style: textTheme.titleSmall?.copyWith(
                                              fontStyle: FontStyle.italic,
                                              overflow:
                                                  TextOverflow.ellipsis))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              Column(mainAxisSize: MainAxisSize.max, children: [
                Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: PopupMenuButton(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Icon(Icons.more_vert_rounded,
                                size: 18, color: appColors.skyDark)),
                        onSelected: (value) {
                          if (value == "edit") {
                            handleEdit();
                          }
                          if (value == "publish") {
                            widget.onPublishHandler(readingListId);
                          }

                          if (value == "delete") {
                            handleDelete();
                          }
                        },
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                  height: 36,
                                  value: 'edit',
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.edit,
                                            size: 18,
                                            color: appColors.inkLighter),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Chỉnh sửa',
                                          style: textTheme.titleMedium,
                                        )
                                      ])),
                              PopupMenuItem(
                                  height: 36,
                                  value: 'publish',
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                            isPrivate
                                                ? Icons.public_rounded
                                                : Icons.lock_rounded,
                                            size: 18,
                                            color: appColors.inkLighter),
                                        const SizedBox(width: 4),
                                        Text(
                                          isPrivate
                                              ? 'Chuyển sang công khai'
                                              : 'Chuyển sang riêng tư',
                                          style: textTheme.titleMedium,
                                        )
                                      ])),
                              PopupMenuItem(
                                  height: 36,
                                  value: 'delete',
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.delete_outline_rounded,
                                            size: 18,
                                            color: appColors.secondaryBase),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Xóa danh sách',
                                          style: textTheme.titleMedium
                                              ?.copyWith(
                                                  color:
                                                      appColors.secondaryBase),
                                        )
                                      ])),
                            ])),
              ]),
            ],
          ),
        ));
  }
}
