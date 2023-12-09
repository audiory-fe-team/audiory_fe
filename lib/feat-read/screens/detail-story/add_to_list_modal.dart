import 'dart:ffi';
import 'dart:io';

import 'package:audiory_v0/feat-read/widgets/selectable_reading_list_card.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/reading-list/reading_list_model.dart';
import 'package:audiory_v0/repositories/reading_list_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/app_img_picker.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddToListModal extends HookWidget {
  final String storyId;

  @override
  AddToListModal({
    super.key,
    required this.storyId,
  });
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    final selectedId = useState<String?>(null);
    final readingListQuery = useQuery(
      ['readingList'],
      () => ReadingListRepository.fetchMyReadingList(),
      refetchOnMount: RefetchOnMount.stale,
      staleDuration: const Duration(seconds: 30),
    );
    final size = MediaQuery.of(context).size;

    final selectImg = useState<File?>(null);

    handleAddToReadingList(BuildContext context) async {
      if (selectedId.value == null) return;
      try {
        await ReadingListRepository.addStoryToReadingList(
            selectedId.value, storyId);

        // Navigator.of(context).pop();
      } catch (e) {
        AppSnackBar.buildTopSnackBar(
            context, "Thêm lỗi", null, SnackBarType.error);
      }
      // listStoriesQuery.refetch();
      await AppSnackBar.buildTopSnackBar(
          context, "Thêm thành công", null, SnackBarType.success);
    }

    handleCreateReadingList() async {
      Map<String, String> body = {};

      const storage = FlutterSecureStorage();
      final jwtToken = await storage.read(key: 'jwt');
      final userId = JwtDecoder.decode(jwtToken ?? '')['user_id'];
      body['user_id'] = userId;
      body['name'] = _formKey.currentState?.fields['name']?.value;
      body['is_private'] = 'true';
      ReadingList? readingList;
      try {
        readingList =
            await ReadingListRepository.addReadingList(body, selectImg.value);
        await AppSnackBar.buildTopSnackBar(
            context, 'Tạo thành công', null, SnackBarType.success);
        readingListQuery.refetch();
      } catch (error) {
        print(error);
        // ignore: use_build_context_synchronously
        AppSnackBar.buildTopSnackBar(
            context, 'Tạo thất bại', null, SnackBarType.error);
      }
    }

    return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8,
        builder: (context, scrollController) => Container(
              height: 300,
              color: appColors.background,
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: appColors.background,
                        border: Border(
                          bottom: BorderSide(
                            color: appColors.skyBase,
                            width: 0.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: IconButton(
                                visualDensity: const VisualDensity(
                                    horizontal: -4, vertical: -4),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon:
                                    const Icon(Icons.close_outlined, size: 18)),
                          ),
                          Flexible(
                              flex: 7,
                              child: GestureDetector(
                                onTap: () {
                                  context.pop();
                                },
                                child: Text(
                                  'Chọn danh sách để thêm ',
                                  textAlign: TextAlign.center,
                                  style: textTheme.titleSmall
                                      ?.copyWith(color: appColors.inkDarkest),
                                ),
                              )),
                          Flexible(
                              flex: 2,
                              child: FilledButton(
                                  onPressed: () {
                                    if (selectedId.value != null) {
                                      handleAddToReadingList(context);
                                    }
                                  },
                                  style: FilledButton.styleFrom(
                                      visualDensity: const VisualDensity(
                                          horizontal: -2, vertical: -2),
                                      padding: EdgeInsets.zero,
                                      backgroundColor: selectedId.value == null
                                          ? appColors.skyBase
                                          : appColors.primaryBase),
                                  child: Text(
                                    'Thêm',
                                    textAlign: TextAlign.center,
                                    style: textTheme.titleMedium
                                        ?.copyWith(color: Colors.white),
                                  ))),
                        ],
                      )),
                  // const SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              scrollable: true,
                              title: Column(children: [
                                Text(
                                  'Tạo một danh sách đọc',
                                  style: textTheme.titleMedium
                                      ?.copyWith(color: appColors.inkDarkest),
                                ),
                                Text(
                                  'Đặt tên cho danh sách đọc của bạn',
                                  style: textTheme.bodySmall
                                      ?.copyWith(color: appColors.inkLight),
                                  textAlign: TextAlign.center,
                                )
                              ]),
                              content: SizedBox(
                                width: size.width / 2,
                                // height: size.height / 2,
                                child: FormBuilder(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AppImagePicker(
                                        callback: (img) {
                                          selectImg.value = File(img.path);
                                        },
                                        width: size.width / 4,
                                        height: 140,
                                      ),
                                      SizedBox(
                                        // height: 70,
                                        child: AppTextInputField(
                                          hintText:
                                              'Ví dụ: Truyện trinh thám hay',
                                          name: 'name',
                                          validator:
                                              FormBuilderValidators.required(
                                                  errorText:
                                                      'Không được để trống'),
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width: 100,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    context.pop();
                                                  },
                                                  child: Text(
                                                    'Hủy',
                                                    style:
                                                        textTheme.titleMedium,
                                                  ),
                                                )),
                                            SizedBox(
                                                width: 100,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    //check if input validate
                                                    final isValid = _formKey
                                                        .currentState
                                                        ?.validate();

                                                    if (isValid != null &&
                                                        isValid) {
                                                      _formKey.currentState
                                                          ?.save();
                                                      context.pop();
                                                      handleCreateReadingList();
                                                    }
                                                    // context.pop();
                                                  },
                                                  child: Text(
                                                    'Tạo',
                                                    textAlign: TextAlign.end,
                                                    style: textTheme.titleMedium?.copyWith(
                                                        color: _formKey
                                                                    .currentState
                                                                    ?.validate() ==
                                                                true
                                                            ? appColors
                                                                ?.primaryBase
                                                            : appColors
                                                                ?.inkLighter),
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
                        },
                        child: Skeleton.shade(
                          child: Container(
                              margin: const EdgeInsets.only(
                                top: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                  color: appColors.skyLightest,
                                  borderRadius: BorderRadius.circular(28)),
                              child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                        Text('Tạo danh sách đọc',
                                            style: textTheme.titleMedium
                                                ?.copyWith(
                                                    color: appColors.inkLight)),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(Icons.add_rounded,
                                            size: 14, color: appColors.inkBase),
                                      ])))),
                        )),
                  ]),
                  const SizedBox(height: 8),
                  Expanded(
                      child: ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    children: List.generate(
                      readingListQuery.data != null
                          ? readingListQuery.data?.length as int
                          : 0,
                      (index) {
                        if (readingListQuery.data == null) {
                          return const SizedBox();
                        }
                        final readingList = readingListQuery.data![index];

                        return Skeletonizer(
                          enabled: readingListQuery.isFetching,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SeletableReadingListCard(
                                readingList: readingList,
                                isSelected: selectedId.value == readingList.id,
                                onSelected: (listId) {
                                  if (selectedId.value == listId) {
                                    selectedId.value = null;
                                  } else {
                                    selectedId.value = listId;
                                  }
                                }),
                          ),
                        );
                      },
                    ).toList(),
                  ))
                ],
              ),
            ));
  }
}
