import 'package:audiory_v0/models/category/app_category_model.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/models/tag/tag_model.dart';
import 'package:audiory_v0/repositories/category_repository.dart';
import 'package:audiory_v0/repositories/chapter_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'dart:convert';

import 'package:audiory_v0/utils/widget_helper.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
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
  bool isEdit = false; //widget is not in initialize, add late instead
  bool? isPaywalled = false;
  //override init state when declare consumerStatefulWidget
  @override
  void initState() {
    super.initState();
    setState(() {
      isEdit = widget.storyId?.trim() != '';
      //tags initial
      _controller = TextfieldTagsController();
    });
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
          children: [
            Flexible(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      'Từ khóa',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(child: _requiredAsterisk())
                ],
              ),
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
                  _controller?.clearTags();
                } else {}
              },
            ),
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
            print('validator ${_controller?.getTags?.length}');
            // if ((_controller?.getTags?.length ?? 0) < 0) {
            //   return 'Nhập ít nhất một thẻ';
            // }
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
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                      borderSide: BorderSide(
                        color: appColors.skyBase,
                        width: 1.0,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                      borderSide: BorderSide(
                        color: appColors.skyBase,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                      borderSide: BorderSide(
                        color: appColors.primaryBase,
                        width: 2.0,
                      ),
                    ),
                    helperText:
                        'Ngăn cách từ khóa bởi dấy phẩy, tối thiểu 1 thẻ',
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

  Future<void> onCreateStoryPressed(Story? story) async {
    print(story?.chapters?[0]);
    if (kDebugMode) {
      print('story');
      print(story);
    }
    // if (story != null) {
    //   await context.push('/composeChapter', extra: {
    //     'story': story,
    //     'chapterId': story.chapters?[0].id ?? '',
    //     'chapter': story.chapters?[0] ?? ''
    //   });
    // } else {}
  }

  Future<void> onEditStoryPressed(Story? story) async {
    if (kDebugMode) {
      print('story');
      print(story);
    }
    if (story != null) {
      // await context.pushNamed('composeChapter', extra: {'story': story});
    } else {}
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
      AppSnackBar.buildTopSnackBar(
          context, content, null, SnackBarType.success);
      // ignore: use_build_context_synchronously
      if (!isEdit) {
        // ignore: use_build_context_synchronously
        context.pushNamed('composeChapter', extra: {
          'chapterId': story.chapters?[0].id,
          'story': story,
          'chapter': story.chapters?[0] ?? ''
        });
      } else {}
    } else {
      content = isEdit ? 'Cập nhật thất bại' : 'Tạo thất bại';
      // ignore: use_build_context_synchronously
      AppSnackBar.buildTopSnackBar(context, content, null, SnackBarType.error);
      // ignore: use_build_context_synchronously
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    //get editing story
    final editStoryByIdQuery = useQuery(
      ['editStory', widget.storyId],
      enabled: context.mounted,
      () => StoryRepostitory().fetchStoryById(widget.storyId ?? ''),
    );

    //get all chapters of edit story
    final chaptersQuery = useQuery(
      ['chapters', widget.storyId],
      enabled: widget.storyId != "",
      () => StoryRepostitory().fetchAllChaptersStoryById(widget.storyId ?? ''),
    );

    final categoryQuery = useQuery(
      ['categories'],
      enabled: true,
      () => CategoryRepository().fetchCategory(),
    );

    handleDeleteChapter(chapterId) async {
      try {
        await ChapterRepository().deleteChapter(chapterId);
        // ignore: use_build_context_synchronously
        AppSnackBar.buildTopSnackBar(
            context, 'Xóa thành công', null, SnackBarType.success);
        chaptersQuery.refetch();
      } catch (e) {
        // ignore: use_build_context_synchronously
        AppSnackBar.buildTopSnackBar(
            context, 'Xóa không thành công', null, SnackBarType.success);
      }
    }

    Future<void> showConfirmChapterDeleteDialog(
        BuildContext context, Chapter chapter) async {
      final AppColors appColors = Theme.of(context).extension<AppColors>()!;

      final textTheme = Theme.of(context).textTheme;
      return showDialog<void>(
        context: context, // User must tap button to close the dialog
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Center(child: Text('Xác nhận xóa?')),
            content: const Text('Bạn chắc chắn muốn xóa chương này'),
            actions: <Widget>[
              SizedBox(
                width: 70,
                height: 30,
                child: AppIconButton(
                  bgColor: appColors.secondaryLight,
                  color: appColors.skyLight,
                  title: 'Có',
                  onPressed: () {
                    // Perform the action
                    handleDeleteChapter(chapter.id);
                    context.pop(); // Dismiss the dialog
                  },
                ),
              ),
              TextButton(
                child: Text(
                  'Hủy',
                  style: textTheme.titleMedium,
                ),
                onPressed: () {
                  context.pop(); // Dismiss the dialog
                },
              ),
            ],
          );
        },
      );
    }

    Widget title({String title = '', bool? isRequired = false}) {
      return Row(
        children: [
          Flexible(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          isRequired == true
              ? Flexible(child: _requiredAsterisk())
              : const SizedBox(
                  height: 0,
                )
        ],
      );
    }

    Widget _createStoryForm(BuildContext context, Story? editStory,
        List<Chapter>? chaptersList, List<AppCategory>? categoryList) {
      final AppColors appColors = Theme.of(context).extension<AppColors>()!;

      return FormBuilder(
        key: _createFormKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  'Ảnh bìa',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(child: _requiredAsterisk())
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
                    fit: BoxFit.cover,
                    validator: FormBuilderValidators.required(
                        errorText: 'Chưa có ảnh bìa'),
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
                            decoration: BoxDecoration(
                                color: appColors.skyLightest,
                                borderRadius: BorderRadius.circular(12)),
                            width: double.infinity,
                            height: double.infinity,
                            child: displayImage)),

                    initialValue:
                        editStory?.id != '' ? [editStory?.coverUrl ?? ''] : [],

                    availableImageSources: const [
                      ImageSourceOption.gallery
                    ], //only gallery
                    name: 'photos',
                    // showDecoration: false,
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

          const SizedBox(
            height: 5,
          ),
          AppTextInputField(
            hintText: 'Nhập tiêu đề',
            label: 'Tiêu đề',
            isRequired: true,
            name: 'title',
            marginVertical: 10,
            initialValue: editStory?.title ?? '',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Tiêu đề rỗng'),
              FormBuilderValidators.maxWordsCount(256,
                  errorText: 'Tối đa 256 ký tự'),
            ]),
          ),
          AppTextInputField(
            name: 'description',
            isTextArea: true,
            label: "Miêu tả",
            isRequired: true,
            minLines: 7,
            maxLengthCharacters: 1000,
            hintText: 'Miêu tả truyện',
            initialValue: editStory != null ? editStory.description ?? '' : '',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Miêu tả rỗng'),
              FormBuilderValidators.maxWordsCount(1000,
                  errorText: 'Tối đa 1000 ký tự'),
            ]),
          ),
          title(title: 'Thể loại', isRequired: true),
          const SizedBox(
            height: 5,
          ),
          FormBuilderDropdown(
              menuMaxHeight: 250,
              decoration: appInputDecoration(context),
              dropdownColor: appColors.skyLightest,
              borderRadius: BorderRadius.circular(4),
              name: 'category',
              initialValue: editStory?.categoryId ?? categoryList?[0].id,
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
          _tagsController(context, editStory?.tags ?? []),
          const SizedBox(
            height: 15,
          ),

          isEdit
              ? FormBuilderSwitch(
                  inactiveThumbColor: appColors.inkLight,
                  inactiveTrackColor: appColors.skyLighter,
                  initialValue: editStory?.isCompleted ?? false,
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
            inactiveThumbColor: appColors.inkLight,
            inactiveTrackColor: appColors.skyLighter,
            initialValue: editStory?.isMature ?? false,
            activeColor: appColors.primaryBase,
            name: 'isMature',
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(title: 'Trưởng thành'),
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
          title(title: 'Bản quyền', isRequired: true),
          const SizedBox(
            height: 5,
          ),
          FormBuilderDropdown(
              dropdownColor: appColors.skyLightest,
              borderRadius: BorderRadius.circular(4),
              onChanged: (value) {
                _createFormKey.currentState?.save();
              },
              decoration: appInputDecoration(context).copyWith(
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
          const SizedBox(
            height: 16,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: SizedBox(
                  width: double.infinity,
                  child: AppIconButton(
                    onPressed: () async {
                      final validationSuccess =
                          _createFormKey.currentState?.validate() ?? false;

                      if (validationSuccess) {
                        _createFormKey.currentState?.save();

                        // create form data

                        Map<String, String> body = <String, String>{};

                        if (isEdit == false) {
                          const storage = FlutterSecureStorage();
                          String? jwtToken = await storage.read(key: 'jwt');

                          String userId =
                              JwtDecoder.decode(jwtToken ?? '')['user_id'];
                          body['author_id'] = userId;
                        } else {
                          body['author_id'] = editStory?.authorId ?? '';
                        }

                        body['category_id'] = _createFormKey
                            .currentState?.fields['category']?.value;
                        //send array to post api
                        List<String>? listOfTags = _controller?.getTags ?? [];
                        List<Object> tags = List.generate(listOfTags.length,
                            (index) => {'name': listOfTags[index]});

                        if (kDebugMode) {
                          print('tags');
                          print(tags);
                        }

                        body['tags'] = jsonEncode(tags);
                        body['description'] = _createFormKey
                            .currentState?.fields['description']?.value;

                        body['is_completed'] = 'false';
                        body['is_copyright'] = _createFormKey
                                .currentState?.fields['isCopyright']?.value
                                .toString() ??
                            'false';

                        body['is_draft'] = 'false';
                        body['is_mature'] = _createFormKey
                                .currentState?.fields['isMature']?.value
                                .toString() ??
                            'false';

                        body['title'] =
                            _createFormKey.currentState?.fields['title']?.value;

                        if (kDebugMode) {
                          print(_createFormKey.currentState?.value);
                          print('body');
                          print(body);
                        }
                        manageStory(
                            isEdit,
                            widget.storyId,
                            body,
                            _createFormKey
                                .currentState?.fields['photos']?.value);
                      }
                    },
                    title: isEdit ? 'Cập nhật' : 'Tạo mới',
                  ),
                ),
              )
            ],
          )
        ]),
      );
    }

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
          enabled: editStoryByIdQuery.isFetching &&
              chaptersQuery.isFetching &&
              categoryQuery.isFetching,
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            editStoryByIdQuery.data != null
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: _createStoryForm(
                      context,
                      editStoryByIdQuery.data,
                      chaptersQuery.data,
                      categoryQuery.data,
                    ))
                : Skeletonizer(enabled: true, child: Text('loading'))
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
