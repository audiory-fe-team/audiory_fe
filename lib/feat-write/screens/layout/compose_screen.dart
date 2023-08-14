import 'package:audiory_v0/models/Category.dart';
import 'package:audiory_v0/services/story.dart';
import 'package:audiory_v0/state/state_manager.dart';
import 'package:audiory_v0/widgets/buttons/icon_button.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/theme_constants.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

class ComposeScreen extends ConsumerWidget {
  ComposeScreen({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  Widget _createStoryForm(context, ref) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final AsyncValue<List<Category>> categoryList =
        ref.watch(categoryFutureProvider);

    return FormBuilder(
      key: _formKey,
      initialValue: {'title': '', 'description': 'Miêu tả'},
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppTextInputField(
          hintText: 'Nhập tiêu đề',
          label: 'Tiêu đề',
          name: 'title',
          marginVertical: 10,
        ),
        AppTextInputField(
          name: 'description',
          isTextArea: true,
          label: "Miêu tả",
          minLines: 7,
          hintText: 'Miêu tả truyện',
        ),
        Text(
          'Thể loại',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        categoryList.when(
            data: (categoryList) => FormBuilderDropdown(
                name: 'category',
                initialValue: categoryList[0].id,
                items: List.generate(
                    categoryList.length,
                    (index) => DropdownMenuItem(
                          child: Text('${categoryList[index].name}'),
                          value: categoryList[index].id,
                        ))),
            error: (err, stack) => Text(err.toString()),
            loading: () => Center(
                  child: CircularProgressIndicator(),
                )),
        SizedBox(
          height: 15,
        ),
        Text(
          'Ảnh',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FormBuilderImagePicker(
              validator: FormBuilderValidators.required(),
              backgroundColor: appColors.skyLighter,
              availableImageSources: [ImageSourceOption.gallery], //only gallery
              name: 'photos',
              // decoration: const InputDecoration(labelText: 'Pick Photos'),
              maxImages: 1,
            ),
          ],
        ),
        Container(
          child: FormBuilderCheckbox(
            contentPadding: EdgeInsets.zero,
            checkColor: appColors.skyLightest,
            activeColor: appColors.primaryBase,
            name: 'isMature',
            title: Text('Truyện có bao hàm nội dung 18+'),
          ),
        ),
        Container(
          child: FormBuilderCheckbox(
              contentPadding: EdgeInsets.zero,
              checkColor: appColors.skyLightest,
              activeColor: appColors.primaryBase,
              name: 'isCopyright',
              title: Text('Truyện không vi phạm bản quyền'),
              validator: FormBuilderValidators.required(
                  errorText: 'Bạn phải xác nhận')),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 120,
              child: AppIconButton(
                onPressed: () {},
                title: 'Hủy',
                bgColor: appColors.skyLighter,
                color: appColors.inkDark,
              ),
            ),
            Container(
              width: 120,
              child: AppIconButton(
                onPressed: () async {
                  print('je');
                  final validationSuccess = _formKey.currentState!.validate();
                  print(_formKey.currentState!.value);

                  if (validationSuccess) {
                    _formKey.currentState!.save();
                    Map<String, dynamic> body = <String, dynamic>{};

                    body['author_id'] = '00529b27-d1e6-698b-beed-ee10b9ed94b4';
                    body['category_id'] =
                        _formKey.currentState!.fields['category']!.value;
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
                    body['paywall_effective_date'] = '';
                    body['title'] =
                        _formKey.currentState!.fields['title']!.value;
                    body['form_file'] = _formKey
                        .currentState!.fields['photos']!.value
                        .toString();

                    print(_formKey.currentState!.value);

                    await StoryRepostitory().createStory(body);

                    // context.go(
                    //     '/composeChapter/${_formKey.currentState!.value['title']}',
                    //     extra: {_formKey.currentState!.value['title']});
                  } else
                    print('isnot');
                },
                title: 'Tạo mới',
              ),
            )
          ],
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      resizeToAvoidBottomInset: false, //avoid keyboard resize screen
      appBar: CustomAppBar(
        leading: IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          'Truyện mới',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: appColors.inkBase),
        ),
        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: _createStoryForm(context, ref),
          )
        ]),
      ),
    );
  }
}
