import 'package:audiory_v0/repositories/story.repository.dart';
import 'dart:convert';

import 'package:audiory_v0/feat-write/widgets/edit_chapter_card.dart';
import 'package:audiory_v0/state/state_manager.dart';
import 'package:audiory_v0/widgets/buttons/icon_button.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../models/Chapter.dart';
import '../../../models/Story.dart';
import '../../../models/Tag.dart';
import '../../../theme/theme_constants.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

class ComposeScreen extends ConsumerStatefulWidget {
  final String? storyId;
  const ComposeScreen({super.key, this.storyId});

  @override
  ConsumerState<ComposeScreen> createState() => _ComposeScreenState();
}

class _ComposeScreenState extends ConsumerState<ComposeScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  //tags
  double? _distanceToField;
  TextfieldTagsController? _controller;

  //check edit mode
  late bool isEdit = widget.storyId!.trim() !=
      ''; //widget is not in initialize, add late instead
  bool? isPaywalled = false;
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

  //override init state when declare consumerStatefulWidget
  @override
  void initState() {
    super.initState();
    // "ref" can be used in all life-cycles of a StatefulWidget.
    ref.read(categoryFutureProvider);
    ref.read(storyByIdFutureProvider(widget.storyId as String));
    ref.read(allChaptersStoryByIdFutureProvider(widget.storyId as String));

    //tags initial
    _controller = TextfieldTagsController();
  }

  Widget _tagsController(context, List<Tag>? tags) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Từ khóa',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
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
                if (_controller!.getTags != null) {
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
              ? List.generate(tags.length, (index) => tags[index].name)
              : [],
          textSeparators: const [','],
          letterCase: LetterCase.normal,
          validator: (String tag) {
            if (tag.trim().length <= 2 && tag.trim().length > 256) {
              return 'Thẻ nhiều hơn 2 ký tự';
            } else if (_controller!.getTags!.contains(tag)) {
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
                        color: appColors.skyBase,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                      borderSide: BorderSide(
                        color: appColors.skyBase,
                        width: 1.0,
                      ),
                    ),
                    helperText: 'Thêm từ khóa giúp tối ưu hóa tìm kiếm truyện',
                    helperStyle: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: appColors.inkBase),
                    hintText: _controller!.hasTags ? '' : "Nhập...",
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

  void _displaySnackBar(String? content) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: appColors.primaryBase,
      duration: const Duration(seconds: 3),
      content: Text(content as String),
      action: SnackBarAction(
        textColor: appColors.skyBase,
        label: 'Undo',
        onPressed: () {},
      ),
    ));
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
      // _displayMotionToast('success', 'Thành công', 'Tạo truyện thành công');
      _displaySnackBar('Tạo truyện thành công');
      await context.pushNamed('composeChapter', extra: {'story': story});
    } else {
      _displaySnackBar('Tạo truyện thất bại');
      // _displayMotionToast('error', 'Lỗi', 'Tạo truyện bị lỗi');
    }
  }

  Widget _createStoryForm(
      BuildContext context, Story? editingStory, List<Chapter>? chaptersList) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final categoryList = ref.watch(categoryFutureProvider);

    return FormBuilder(
      key: _formKey,
      initialValue: const {'title': '', 'description': 'Miêu tả'},
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Ảnh',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: FormBuilderImagePicker(
                fit: BoxFit.fill,
                validator: FormBuilderValidators.required(),
                backgroundColor: appColors.skyLighter,
                initialValue: [editingStory?.coverUrl],
                availableImageSources: const [
                  ImageSourceOption.gallery
                ], //only gallery
                name: 'photos',
                // decoration: const InputDecoration(labelText: 'Pick Photos'),
                maxImages: 1,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        AppTextInputField(
          hintText: 'Nhập tiêu đề',
          label: 'Tiêu đề',
          name: 'title',
          marginVertical: 10,
          initialValue: isEdit ? editingStory?.title : '',
        ),
        AppTextInputField(
          name: 'description',
          isTextArea: true,
          label: "Miêu tả",
          minLines: 7,
          hintText: 'Miêu tả truyện',
          initialValue: isEdit ? editingStory?.description : '',
        ),
        Text(
          'Thể loại',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        categoryList.when(
            data: (categoryList) => FormBuilderDropdown(
                name: 'category',
                initialValue: editingStory?.categoryId ?? categoryList[0].id,
                selectedItemBuilder: (context) => List.generate(
                      categoryList.length,
                      (index) => Text(
                        categoryList[index].name as String,
                        selectionColor: appColors.primaryBase,
                      ),
                    ),
                focusColor: appColors.primaryBase,
                items: List.generate(
                    categoryList.length,
                    (index) => DropdownMenuItem(
                          value: categoryList[index].id,
                          child: Text(
                            '${categoryList[index].name}',
                          ),
                        ))),
            error: (err, stack) => Text(err.toString()),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )),
        const SizedBox(
          height: 15,
        ),
        _tagsController(context, editingStory?.tags),
        const SizedBox(
          height: 15,
        ),

        isEdit
            ? FormBuilderSwitch(
                initialValue: editingStory?.isCompleted ?? false,
                activeColor: appColors.primaryBase,
                decoration: InputDecoration(focusColor: appColors.primaryBase),
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
          initialValue: editingStory?.isMature ?? false,
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
        //additional form for editing
        isEdit
            ? FormBuilderSwitch(
                initialValue:
                    editingStory != null ? editingStory?.isPaywalled : false,
                activeColor: appColors.primaryBase,
                onChanged: (value) {
                  setState(() {
                    isPaywalled = value as bool;
                  });
                },
                name: 'isPaywalled',
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thu phí trên truyện này',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: appColors.inkBase),
                    ),
                    Text(
                      'Bật tính năng này giúp bạn có thêm động lực ra truyện',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: appColors.inkLighter),
                    ),
                  ],
                ),
              )
            : const SizedBox(
                height: 0,
              ),
        isPaywalled != false
            ? Column(
                children: [
                  AppTextInputField(
                    name: 'coinCost',
                    textInputType: TextInputType.number,
                    label: "Phí mỗi chương",
                    hintText: 'Nhập số coin mong muốn',
                    initialValue:
                        isEdit ? '${editingStory?.coinCost.toString()}' : '0',
                  ),
                  // this can be null ??? why
                  AppTextInputField(
                    name: 'numFreeChapters',
                    textInputType: TextInputType.number,
                    label: "Số chương miễn phí",
                    hintText: 'Nhập số chương mong muốn',
                    initialValue: isEdit
                        ? '${editingStory?.numFreeChapters.toString()}'
                        : '0',
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                ],
              )
            : const SizedBox(
                height: 0,
              ),

        FormBuilderCheckbox(
            initialValue: editingStory?.isCopyright,
            contentPadding: EdgeInsets.zero,
            checkColor: appColors.skyLightest,
            activeColor: appColors.primaryBase,
            name: 'isCopyright',
            title: const Text('Truyện không vi phạm bản quyền'),
            validator:
                FormBuilderValidators.required(errorText: 'Bạn phải xác nhận')),
        //chapters list
        Row(
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
              '${editingStory?.chapters!.length} chương',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold, color: appColors.inkLighter),
            ),
          ],
        ),
        // provider for chapters
        editingStory != null && editingStory.chapters!.isNotEmpty
            ? Column(
                children:
                    List?.generate(editingStory.chapters!.length, (index) {
                  return EditChapterCard(
                    index: index + 1,
                    chapter: editingStory.chapters![index],
                  );
                }),
              )
            : const SizedBox(
                height: 0,
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
                  final validationSuccess = _formKey.currentState!.validate();
                  if (kDebugMode) {
                    print(_formKey.currentState!.value);
                  }

                  if (validationSuccess) {
                    _formKey.currentState!.save();

                    //create form data

                    Map<String, String> body = <String, String>{};

                    body['author_id'] = '72d9245a-399d-11ee-8181-0242ac120002';
                    body['category_id'] =
                        _formKey.currentState!.fields['category']!.value;
                    //send array to post api
                    List<String>? listOfTags = _controller!.getTags!;
                    List<Object> tags = List.generate(listOfTags.length,
                        (index) => {'name': listOfTags[index]});

                    if (kDebugMode) {
                      print(listOfTags);
                      print('tags');
                      print(tags);
                    }
                    body['tags'] = jsonEncode(tags);
                    body['coin_cost'] = '100';
                    body['description'] =
                        _formKey.currentState!.fields['description']!.value;

                    body['is_completed'] = 'false';
                    body['is_copyright'] = _formKey
                        .currentState!.fields['isCopyright']!.value
                        .toString();

                    body['is_draft'] = 'false';
                    body['is_mature'] = _formKey
                        .currentState!.fields['isMature']!.value
                        .toString();
                    body['is_paywalled'] = 'false';
                    // body['paywall_effective_date'] = null;
                    body['title'] =
                        _formKey.currentState!.fields['title']!.value;
                    body['form_file'] = _formKey
                        .currentState!.fields['photos']!.value
                        .toString();

                    if (kDebugMode) {
                      print(_formKey.currentState!.value);
                      print('body');
                      print(body);
                    }

                    Story? story = await StoryRepostitory().createStory(
                        body, _formKey.currentState!.fields['photos']!.value);

                    onCreateStoryPressed(story);
                  }
                },
                title: isEdit ? 'Cập nhật' : 'Tạo mới',
              ),
            )
          ],
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    //get editing story
    final AsyncValue<Story?>? editStory = isEdit
        ? ref.watch(storyByIdFutureProvider(widget.storyId as String))
        : null;

    //get all chapters of edit story
    final AsyncValue<List<Chapter>?>? chaptersOfEditStory = isEdit
        ? ref
            .watch(allChaptersStoryByIdFutureProvider(widget.storyId as String))
        : null;
    return Scaffold(
      resizeToAvoidBottomInset: true, //avoid keyboard resize screen=> false
      appBar: CustomAppBar(
        leading: IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          isEdit ? 'Sửa truyện' : 'Truyện mới',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: appColors.inkBase),
        ),
        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          editStory != null
              ? editStory.when(
                  data: (story) => Padding(
                        padding: const EdgeInsets.all(16),
                        child: _createStoryForm(context, story, null),
                      ),
                  error: (err, stack) => Text(err.toString()),
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: _createStoryForm(context, null, null),
                ),
        ]),
      ),
    );
  }
}
