import 'dart:math';

import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DetailMessageBottomBar extends StatefulWidget {
  final Function sendMessageCallback;
  const DetailMessageBottomBar({super.key, required this.sendMessageCallback});

  @override
  State<DetailMessageBottomBar> createState() => _DetailMessageBottomBarState();
}

class _DetailMessageBottomBarState extends State<DetailMessageBottomBar> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: Colors.transparent),
      width: double.infinity,
      height: 90,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 5,
                child: FormBuilder(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: AppTextInputField(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      isNoError: true,
                      name: 'content',
                      suffixIcon: GestureDetector(
                        onTap: () {},
                        child: Transform.rotate(
                            angle: 45 * pi / 180,
                            child: const Icon(
                              Icons.attach_file_outlined,
                              size: 24,
                            )),
                      ),
                    ),
                  ),
                )),
            Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: appColors.primaryLightest,
                      borderRadius: BorderRadius.circular(50)),
                  width: 65,
                  height: 60,
                  child: IconButton(
                    icon: Transform.rotate(
                      angle: -45 * pi / 180,
                      child: Icon(
                        size: 24,
                        Icons.send,
                        color: appColors.primaryDark,
                      ),
                    ),
                    onPressed: () {
                      bool isValid = _formKey.currentState!.validate();
                      if (isValid) {
                        String content =
                            _formKey.currentState!.fields['content']?.value;
                        widget.sendMessageCallback(content);
                        _formKey.currentState?.reset();
                      }
                    },
                  ),
                ))
          ]),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
