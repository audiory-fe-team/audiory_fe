import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../theme/theme_constants.dart';

class AppTextInputField extends StatefulWidget {
  //container size
  final double? width;
  //position
  final double? marginVertical;
  final double? marginHorizontal;
  final double? paddingVertical;
  final double? paddingHorizontal;
  final double? sizeBoxHeight;

  //type
  final bool? isTextArea;
  final int? minLines;

  //label
  final String? label;
  final TextStyle? labelTextStyle;

  //textinput field
  final String name; //form field name, must have
  final String? initialValue;
  final String? hintText;

  const AppTextInputField(
      {super.key,
      this.label,
      this.labelTextStyle,
      this.initialValue = '',
      required this.name,
      this.marginVertical = 0,
      this.marginHorizontal = 0,
      this.paddingVertical = 0,
      this.paddingHorizontal = 0,
      this.width = double.infinity,
      this.sizeBoxHeight = 5,
      this.hintText = '',
      this.isTextArea = false,
      this.minLines = 1});

  @override
  State<AppTextInputField> createState() => _AppTextInputFieldState();
}

class _AppTextInputFieldState extends State<AppTextInputField> {
  String _enteredText = '';

  Widget _inputTextFormField(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return FormBuilderTextField(
      onChanged: (value) => {
        setState(() {
          _enteredText = value as String;
        })
      },
      name: widget.name,
      initialValue: widget.initialValue!,
      minLines: widget.minLines!,
      maxLines: widget.minLines! ?? null, //dynamic height
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: appColors.skyDark,
          ),
          borderRadius: widget.isTextArea != null && widget.isTextArea == true
              ? BorderRadius.all(Radius.circular(10))
              : BorderRadius.all(Radius.circular(80)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Color(0xFF439A97),
          ),
          borderRadius: widget.isTextArea != null && widget.isTextArea == true
              ? BorderRadius.all(Radius.circular(10))
              : BorderRadius.all(Radius.circular(80)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Color(0xFF439A97),
          ),
          borderRadius: widget.isTextArea != null && widget.isTextArea == true
              ? BorderRadius.all(Radius.circular(10))
              : BorderRadius.all(Radius.circular(80)),
        ),
        filled: true,
        hintText: widget.hintText!,
        hintStyle: TextStyle(
          color: appColors.skyDark,
        ),
        counterText: widget.isTextArea != null && widget.isTextArea == true
            ? '${_enteredText.length.toString()} từ'
            : null,

        counterStyle: Theme.of(context).textTheme.bodyLarge,
        fillColor: appColors.skyLightest,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12),
        // labelText: "Email",
        focusColor: Colors.black12,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Container(
        width: widget.width!,
        margin: EdgeInsets.symmetric(
            vertical: widget.marginVertical!,
            horizontal: widget.marginHorizontal!),
        padding: EdgeInsets.symmetric(
            vertical: widget.paddingVertical!,
            horizontal: widget.paddingHorizontal!),
        child: widget.label != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                      widget.label as String,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: widget.sizeBoxHeight!,
                    ),
                    widget.isTextArea != null
                        ? _inputTextFormField(context)
                        : _inputTextFormField(context)
                  ])
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_inputTextFormField(context)]));
  }
}
