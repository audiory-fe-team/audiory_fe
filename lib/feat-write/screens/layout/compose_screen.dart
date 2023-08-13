import 'package:audiory_v0/widgets/buttons/icon_button.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/theme_constants.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ComposeScreen extends StatefulWidget {
  const ComposeScreen({super.key});

  @override
  State<ComposeScreen> createState() => _ComposeScreenState();
}

class _ComposeScreenState extends State<ComposeScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  Widget _createStoryForm() {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return FormBuilder(
      key: _formKey,
      initialValue: {'title': '', 'description': 'Miêu tả'},
      child: Column(children: [
        AppTextInputField(
          hintText: 'Nhập tiêu đề',
          label: 'Tiêu đề',
          name: 'title',
          marginVertical: 10,
        ),
        AppTextInputField(
          hintText: 'Nhập miêu tả truyện',
          label: 'Miêu tả',
          name: 'description',
          marginVertical: 10,
          isTextArea: true,
          minLines: 7,
        ),
        FormBuilderTextField(name: 'description'),
        FormBuilderDropdown(name: 'category', initialValue: 1, items: const [
          DropdownMenuItem(
            child: Text('The loai 1'),
            value: 1,
          ),
          DropdownMenuItem(
            child: Text('The loai 2'),
            value: 2,
          ),
          DropdownMenuItem(
            child: Text('The loai 3'),
            value: 3,
          ),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 100,
              child: AppIconButton(
                onPressed: () {},
                title: 'Hủy',
                bgColor: appColors.skyLighter,
                color: appColors.inkDark,
              ),
            ),
            Container(
              width: 100,
              child: AppIconButton(
                onPressed: () {
                  _formKey.currentState!.save();
                  context.go(
                      '/composeChapter/${_formKey.currentState!.value['title']}',
                      extra: {_formKey.currentState!.value['title']});
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
  Widget build(BuildContext context) {
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
      body: Column(children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: _createStoryForm(),
        )
      ]),
    );
  }
}
