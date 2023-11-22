import 'package:audiory_v0/models/category/app_category_model.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/models/tag/tag_model.dart';
import 'package:audiory_v0/repositories/category_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'dart:convert';

import 'package:audiory_v0/feat-write/widgets/edit_chapter_card.dart';
import 'package:audiory_v0/state/state_manager.dart';
import 'package:audiory_v0/utils/widget_helper.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../theme/theme_constants.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

class ComposeScreen extends StatefulHookWidget {
  final String? storyId;
  const ComposeScreen({super.key, this.storyId});

  @override
  State<ComposeScreen> createState() => _ComposeScreenState();
}

class _ComposeScreenState extends State<ComposeScreen> {
  final _createFormKey = GlobalKey<FormBuilderState>();

  //tags
  double? _distanceToField;
  TextfieldTagsController? _controller;

  //check edit mode
  late bool isEdit = false; //widget is not in initialize, add late instead
  bool? isPaywalled = false;
  //override init state when declare consumerStatefulWidget
  @override
  void initState() {
    super.initState();
    setState(() {
      isEdit = widget.storyId!.trim() != '';
    });

    //tags initial
    _controller = TextfieldTagsController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  Widget _requiredAsterisk() {
    return Text(
      '*',
      style: Theme.of(context)
          .textTheme
          .headlineMedium
          ?.copyWith(color: Colors.red),
    );
  }

  Widget _tagsController(context, List<Tag>? tags) {
    //at least one tag
    //each tag has length 2<= tag <=256
    //each tag can contain special character except comma(,)
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Từ khóa',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                _requiredAsterisk()
              ],
            ),
            GestureDetector(
              child: Text(
                'Xóa tất cả',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: appColors.primaryBase,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.sourceSansPro().fontFamily),
              ),
              onTap: () {
                if (_controller?.getTags != null) {
                } else {}
              },
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        TextFieldTags(
          textfieldTagsController: _controller!,
          initialTags: tags != null
              ? List.generate(tags.length, (index) => tags[index].name ?? '')
              : [],
          textSeparators: const [','], //add enter keyup
          letterCase: LetterCase.normal,
          validator: (String tag) {
            if (tag.trim().length < 2 || tag.trim().length > 256) {
              return 'Thẻ nhiều hơn 2 ký tự';
            } else if (_controller?.getTags?.contains(tag) ?? false) {
              return 'Lặp từ khóa';
            }
            return null;
          },
          inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
            return ((context, sc, tags, onTagDelete) {
              return Padding(
                padding: const EdgeInsets.all(0),
                child: TextField(
                  controller: tec,
                  focusNode: fn,
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                      borderSide: BorderSide(
                        color: appColors.skyLight,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                      borderSide: BorderSide(
                        color: appColors.primaryBase,
                        width: 1.0,
                      ),
                    ),
                    helperText: 'Thêm từ khóa giúp tối ưu hóa tìm kiếm truyện',
                    helperStyle: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: appColors.inkBase),
                    hintText: _controller?.hasTags ?? false ? '' : "Nhập...",
                    errorText: error,
                    prefixIconConstraints:
                        BoxConstraints(maxWidth: _distanceToField! * 0.74),
                    prefixIcon: tags.isNotEmpty
                        ? SingleChildScrollView(
                            controller: sc,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: tags.map((String tag) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                  color: appColors.primaryBase,
                                ),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 7.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        '#$tag',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      onTap: () {
                                        //print("$tag selected");
                                      },
                                    ),
                                    const SizedBox(width: 4.0),
                                    InkWell(
                                      child: const Icon(
                                        Icons.cancel,
                                        size: 14.0,
                                        color:
                                            Color.fromARGB(255, 233, 233, 233),
                                      ),
                                      onTap: () {
                                        onTagDelete(tag);
                                      },
                                    )
                                  ],
                                ),
                              );
                            }).toList()),
                          )
                        : null,
                  ),
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                ),
              );
            });
          },
        ),
      ],
    );
  }

  void _displayMotionToast(String? type, String? title, String? des) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    MotionToast toast = type == 'success'
        ? MotionToast.success(
            height: 50,
            width: double.infinity,
            title: Text(
              title!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            description: Text(
              des!,
              style: const TextStyle(fontSize: 12),
            ),
            layoutOrientation: ToastOrientation.ltr,
            animationCurve: Curves.bounceIn,
            dismissable: true,
            toastDuration: const Duration(seconds: 3),
          )
        : MotionToast.error(
            height: 50,
            width: double.infinity,
            title: Text(
              title!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            description: Text(
              des!,
              style: const TextStyle(fontSize: 12),
            ),
            layoutOrientation: ToastOrientation.ltr,
            animationCurve: Curves.bounceIn,
            dismissable: true,
            toastDuration: const Duration(seconds: 3),
          );
    toast.show(context);
    // Future.delayed(const Duration(seconds: 3)).then((value) {
    //   toast.dismiss();
    // });
  }

  Future<void> onCreateStoryPressed(Story? story) async {
    if (kDebugMode) {
      print('story');
      print(story);
    }
    if (story != null) {
      await context.push('/composeChapter', extra: {'story': story});
    } else {}
  }

  Future<void> onEditStoryPressed(Story? story) async {
    if (kDebugMode) {
      print('story');
      print(story);
    }
    if (story != null) {
      // await context.pushNamed('composeChapter', extra: {'story': story});
    } else {
      // _displayMotionToast('error', 'Lỗi', 'Tạo truyện bị lỗi');
    }
  }

  Future<void> manageStory(
      isEdit, String? storyId, Map<String, String>? body, formFile) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    Story? story = isEdit
        ? await StoryRepostitory().editStory(storyId ?? '', body,
            _createFormKey.currentState?.fields['photos']?.value)
        : await StoryRepostitory().createStory(
            body, _createFormKey.currentState?.fields['photos']?.value);

    //hide progress
    // ignore: use_build_context_synchronously
    context.pop();

    String content;
    print(story);
    if (story != null) {
      content = isEdit ? 'Cập nhật thành công' : 'Tạo thành công';

      // ignore: use_build_context_synchronously
      context.pushNamed('composeChapter',
          extra: {'chapterId': story.chapters?[0].id, 'story': story});
    } else {
      content = isEdit ? 'Cập nhật thất bại' : 'Tạo thất bại';

      // ignore: use_build_context_synchronously
      context.pushNamed('composeChapter',
          extra: {'chapterId': story?.chapters?[0].id, 'story': story});
    }
  }

  Widget _createStoryForm(
      BuildContext context,
      UseQueryResult<Story?, dynamic> editingStoryQuery,
      List<Chapter>? chaptersList,
      List<AppCategory>? categoryList) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    return FormBuilder(
      key: _createFormKey,
      child: Skeletonizer(
        enabled: editingStoryQuery.isFetching,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Text(
                'Ảnh bìa',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              _requiredAsterisk()
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: SizedBox(
                  width: 100,
                  child: FormBuilderImagePicker(
                    previewWidth: 108,
                    previewHeight: 145,
                    fit: BoxFit.fitWidth,
                    validator: FormBuilderValidators.required(
                        errorText: 'Ảnh bìa là bắt buộc'),
                    placeholderWidget: Container(
                      decoration: BoxDecoration(
                        color: appColors.skyLightest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                          child: Icon(
                        Icons.add,
                        color: appColors.inkLight,
                      )),
                    ),

                    transformImageWidget: (context, displayImage) => Center(
                        child: Container(
                            decoration:
                                BoxDecoration(color: appColors.skyLightest),
                            width: double.infinity,
                            child: displayImage)),

                    initialValue: editingStoryQuery.data != null
                        ? [editingStoryQuery.data?.coverUrl ?? '']
                        : null,

                    availableImageSources: const [
                      ImageSourceOption.gallery
                    ], //only gallery
                    name: 'photos',
                    showDecoration: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: appColors.secondaryBase,
                    ),
                    maxImages: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          // Row(
          //   children: [
          //     Text(
          //       'Ảnh nền',
          //       style: Theme.of(context)
          //           .textTheme
          //           .titleLarge
          //           ?.copyWith(fontWeight: FontWeight.bold),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 5,
          // ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisSize: MainAxisSize.min,
          //   children: <Widget>[
          //     Center(
          //       child: SizedBox(
          //         child: FormBuilderImagePicker(
          //           previewWidth: 108,
          //           previewHeight: 145,
          //           fit: BoxFit.contain,
          //           validator: FormBuilderValidators.required(
          //               errorText: 'Ảnh bìa là bắt buộc'),
          //           placeholderWidget: Container(
          //             decoration: BoxDecoration(
          //               color: appColors.skyLighter,
          //               borderRadius: BorderRadius.circular(12),
          //             ),
          //             child: Center(
          //                 child: Icon(
          //               Icons.add,
          //               color: appColors.inkLight,
          //             )),
          //           ),

          //           initialValue: [editingStory?.coverUrl],
          //           availableImageSources: const [
          //             ImageSourceOption.gallery
          //           ], //only gallery
          //           name: 'background_image',
          //           showDecoration: false,
          //           decoration: InputDecoration(
          //             border: InputBorder.none,
          //             fillColor: appColors.secondaryBase,
          //           ),
          //           maxImages: 1,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 5,
          // ),
          AppTextInputField(
            hintText: 'Nhập tiêu đề',
            label: 'Tiêu đề',
            isRequired: true,
            name: 'title',
            marginVertical: 10,
            initialValue: isEdit ? editingStoryQuery.data?.title : '',
          ),
          Skeletonizer(
            enabled: editingStoryQuery.isFetching,
            child: AppTextInputField(
              name: 'description',
              isTextArea: true,
              label: "Miêu tả",
              isRequired: true,
              minLines: 7,
              maxLengthCharacters: 1000,
              hintText: 'Miêu tả truyện',
              initialValue:
                  isEdit ? editingStoryQuery.data?.description ?? '' : '',
            ),
          ),
          Row(
            children: [
              Text(
                'Thể loại',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              _requiredAsterisk()
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          FormBuilderDropdown(
              decoration: appInputDecoration(context),
              name: 'category',
              initialValue:
                  editingStoryQuery.data?.categoryId ?? categoryList?[0].id,
              selectedItemBuilder: (context) => List.generate(
                    categoryList?.length ?? 0,
                    (index) => Text(
                      categoryList?[index].name ?? '',
                      selectionColor: appColors.primaryBase,
                    ),
                  ),
              focusColor: appColors.primaryBase,
              items: List.generate(
                  categoryList?.length ?? 0,
                  (index) => DropdownMenuItem(
                        value: categoryList?[index].id,
                        child: Text(
                          '${categoryList?[index].name}',
                        ),
                      ))),

          const SizedBox(
            height: 15,
          ),
          _tagsController(context, editingStoryQuery.data?.tags),
          const SizedBox(
            height: 15,
          ),

          isEdit
              ? FormBuilderSwitch(
                  initialValue: editingStoryQuery.data?.isCompleted ?? false,
                  activeColor: appColors.primaryBase,
                  decoration: const InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none),
                  name: 'isComplete',
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Đã hoàn thành',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: appColors.inkBase),
                      ),
                    ],
                  ),
                )
              : const SizedBox(
                  height: 0,
                ),

          FormBuilderSwitch(
            initialValue: editingStoryQuery.data?.isMature ?? false,
            activeColor: appColors.primaryBase,
            name: 'isMature',
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trưởng thành',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: appColors.inkBase),
                ),
                Text(
                  'Truyện bao hàm nội dung dành cho người trưởng thành, Audiory có thể xếp loại truyện của bạn là trưởng thành',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: appColors.inkLighter),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                'Bản quyền',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              _requiredAsterisk()
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          FormBuilderDropdown(
              onChanged: (value) {
                _createFormKey.currentState!.save();
              },
              decoration: appInputDecoration(context)!.copyWith(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0))),
              name: 'isCopyright',
              initialValue: CopyRights.values[0].isCopyRight,
              selectedItemBuilder: (context) => List.generate(
                    CopyRights.values.length,
                    (index) => Text(
                      CopyRights.values[index].copyRightTitle,
                      selectionColor: appColors.primaryBase,
                    ),
                  ),
              items: List.generate(
                  CopyRights.values.length,
                  (index) => DropdownMenuItem(
                        value: CopyRights.values[index].isCopyRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              CopyRights.values[index].copyRightTitle,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              CopyRights.values[index].copyRightContent,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: appColors.inkLight),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ))),

          //additional form for editing
          //only true when coin_cost > 0

          //chapters list
          isEdit
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mục lục',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${chaptersList?.length ?? 0} chương',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: appColors.inkLighter),
                    ),
                  ],
                )
              : const SizedBox(
                  height: 0,
                ),
          // provider for chapters

          chaptersList != null && chaptersList.isNotEmpty == true
              ? Column(
                  children: List?.generate(chaptersList.length ?? 0, (index) {
                    return EditChapterCard(
                        index: index + 1,
                        chapter: chaptersList[index],
                        story: editingStoryQuery.data);
                  }),
                )
              : const SizedBox(
                  height: 0,
                ),
          editingStoryQuery.data != null
              ? Center(
                  child: GestureDetector(
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Thêm chương mới'),
                    ),
                    onTap: () async {
                      // Chapter? newChapter = (await ChapterApi()
                      //     .createChapter(editingStory)) as Chapter?;
                      // context.pushNamed('composeChapter',
                      //     extra: {'story': editingStory, 'chapterId': ''});
                    },
                  ),
                )
              : const SizedBox(
                  height: 0,
                ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 120,
                child: AppIconButton(
                  onPressed: () {},
                  title: 'Hủy',
                  bgColor: appColors.skyLighter,
                  color: appColors.inkDark,
                ),
              ),
              SizedBox(
                width: 120,
                child: AppIconButton(
                  onPressed: () async {
                    final validationSuccess =
                        _createFormKey.currentState?.validate() ?? false;

                    if (validationSuccess) {
                      _createFormKey.currentState?.save();

                      //create form data

                      // Map<String, String> body = <String, String>{};

                      // body['author_id'] = '72d9245a-399d-11ee-8181-0242ac120002';
                      // body['category_id'] =
                      //     _createFormKey.currentState!.fields['category']!.value;
                      // //send array to post api
                      // List<String>? listOfTags = _controller!.getTags!;
                      // List<Object> tags = List.generate(listOfTags.length,
                      //     (index) => {'name': listOfTags[index]});

                      // if (kDebugMode) {
                      //   print(listOfTags);
                      //   print('tags');
                      //   print(tags);
                      // }
                      // body['tags'] = jsonEncode(tags);
                      // body['description'] =
                      //     _createFormKey.currentState!.fields['description']!.value;

                      // body['is_completed'] = 'false';
                      // body['is_copyright'] = _createFormKey
                      //     .currentState!.fields['isCopyright']?.value
                      //     .toString() as String;

                      // body['is_draft'] = 'false';
                      // body['is_mature'] = _createFormKey
                      //     .currentState!.fields['isMature']?.value
                      //     .toString() as String;

                      // body['title'] =
                      //     _createFormKey.currentState!.fields['title']!.value;
                      // body['form_file'] = _createFormKey
                      //     .currentState!.fields['photos']!.value
                      //     .toString();

                      // //edit body
                      // body['is_paywalled'] = isEdit
                      //     ? _createFormKey.currentState!.fields['isPaywalled']!.value
                      //         .toString()
                      //     : 'false';

                      // if (isEdit) {
                      //   body['paywall_effective_date'] =
                      //       DateTime.now().toUtc().toIso8601String();
                      //   body['coin_cost'] =
                      //       _createFormKey.currentState!.fields['isPaywalled']!.value
                      //           ? _createFormKey.currentState!.fields['coinCost']!.value
                      //               .toString()
                      //           : '0';

                      //   body['num_free_chapters'] =
                      //       _createFormKey.currentState!.fields['isPaywalled']!.value
                      //           ? _createFormKey.currentState!
                      //               .fields['numFreeChapters']!.value
                      //               .toString()
                      //           : '0';
                      // }
                      // if (kDebugMode) {
                      //   print(_createFormKey.currentState!.value);
                      //   print('body');
                      //   print(body);
                      // }
                      // manageStory(isEdit, editingStory?.id, body,
                      //     _createFormKey.currentState!.fields['photos']!.value);
                      // Story? story = isEdit
                      //     ? await StoryRepostitory().editStory(
                      //         editingStory?.id,
                      //         body,
                      //         _createFormKey.currentState!.fields['photos']!.value)
                      //     : await StoryRepostitory().createStory(body,
                      //         _createFormKey.currentState!.fields['photos']!.value);
                      // isEdit
                      //     ? onEditStoryPressed(story)
                      //     : onCreateStoryPressed(story);
                    }
                  },
                  title: isEdit ? 'Cập nhật' : 'Tạo mới',
                ),
              )
            ],
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    //get editing story
    final editStoryByIdQuery = useQuery(
      ['editStory', widget.storyId],
      enabled: isEdit == true,
      () => StoryRepostitory().fetchStoryById(widget.storyId ?? ''),
    );

    //get all chapters of edit story
    final chaptersQuery = useQuery(
      ['chapters', widget.storyId],
      enabled: isEdit == true,
      () => StoryRepostitory().fetchAllChaptersStoryById(widget.storyId ?? ''),
    );

    final categoryQuery = useQuery(
      ['categories'],
      enabled: true,
      () => CategoryRepository().fetchCategory(),
    );

    return Scaffold(
      resizeToAvoidBottomInset: true, //avoid keyboard resize screen=> false
      appBar: CustomAppBar(
        title: Text(
          isEdit ? 'Sửa truyện ' : 'Truyện mới',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: appColors.inkBase),
        ),
        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
      ),
      body: SingleChildScrollView(
        child: Skeletonizer(
          enabled: editStoryByIdQuery.isFetching,
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            editStoryByIdQuery.data != null
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: _createStoryForm(context, editStoryByIdQuery,
                        chaptersQuery.data, categoryQuery.data),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: _createStoryForm(
                        context, editStoryByIdQuery, null, null),
                  ),
          ]),
        ),
      ),
    );
  }
}

enum CopyRights {
  isCopy(true, 'Bảo lưu mọi quyền',
      'Bạn không cho phép người khác sử dụng hay chỉnh sửa tác phẩm dưới bất kỳ hình thức nào mà không có sự cho phép của bạn'),
  isNotCopy(false, 'Phạm vi công cộng',
      'Điều này cho phép bất cứ ai sử dụng truyện của bạn cho bất kỳ mục đích nào - họ có thể in ấn, bán haowjc chuyển thể truyện của bạn thành phim');

  const CopyRights(
      this.isCopyRight, this.copyRightTitle, this.copyRightContent);
  final bool isCopyRight;
  final String copyRightTitle;
  final String copyRightContent;
}
