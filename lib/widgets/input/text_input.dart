import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../theme/theme_constants.dart';

class AppTextInputField extends StatefulWidget {
  //container size
  final double? width;
  //position
  final double? marginVertical;
  final double? marginHorizontal;
  final double? marginBottom;
  final double? paddingVertical;
  final double? paddingHorizontal;
  final double? sizeBoxHeight;
  final EdgeInsets? contentPadding;

  //type
  final bool? isTextArea;
  final bool? isNoError;
  final bool? isDisabled;
  final int? maxLengthCharacters;
  final int? minLines;
  final int? maxLines;

  //label
  final String? label;
  final TextStyle? labelTextStyle;
  final bool? isRequired;
  final String? Function(String?)? validator;
  final bool? submmitted;

  //textinput field
  final String name; //form field name, must have
  final TextInputType? textInputType; //form field name, must have
  final String? initialValue;
  final String? hintText;
  final TextAlign? textAlign;
  final TextStyle? hintTextStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? backgroundColor;

  //function callback
  final Function? onChangeCallback;
  const AppTextInputField({
    super.key,
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
    this.minLines = 1,
    this.maxLines = 10,
    this.hintTextStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputType = TextInputType.text,
    this.isRequired = false,
    this.validator,
    this.textAlign,
    this.maxLengthCharacters,
    this.marginBottom = 16,
    this.isDisabled = true,
    this.submmitted = false,
    this.backgroundColor = Colors.transparent,
    this.isNoError = false,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
    this.onChangeCallback,
  });

  @override
  State<AppTextInputField> createState() => _AppTextInputFieldState();
}

class _AppTextInputFieldState extends State<AppTextInputField> {
  late String _enteredText =
      widget.initialValue != '' ? widget.initialValue as String : '';
  Widget _requiredAsterisk() {
    return Text(
      ' *',
      style: Theme.of(context)
          .textTheme
          .headlineMedium
          ?.copyWith(color: Colors.red),
    );
  }

  Widget _inputTextFormField(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return FormBuilderTextField(
      // autofocus: false,
      obscureText:
          widget.textInputType == TextInputType.visiblePassword ? true : false,
      enabled: widget.isDisabled == true,
      onChanged: (value) {
        setState(() {
          _enteredText = value as String;
        });
        widget.onChangeCallback;
      },

      textAlign: widget.textAlign ?? TextAlign.left,
      keyboardType: widget.textInputType,
      name: widget.name,
      initialValue: widget.initialValue!,
      minLines: widget.textInputType == TextInputType.visiblePassword
          ? 1
          : widget.minLines!,
      maxLines: widget.textInputType == TextInputType.visiblePassword
          ? 1
          : widget.maxLines!, //dynamic height
      maxLength: widget.maxLengthCharacters,
      cursorColor: appColors.primaryBase,
      decoration: InputDecoration(
        errorStyle: widget.isNoError == true ? TextStyle(height: 0) : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: appColors.skyBase,
          ),
          borderRadius: widget.isTextArea != null && widget.isTextArea! == true
              ? const BorderRadius.all(Radius.circular(10))
              : const BorderRadius.all(Radius.circular(80)),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            style: BorderStyle.solid,
            color: Color(0xFF439A97),
          ),
          borderRadius: widget.isTextArea != null && widget.isTextArea == true
              ? const BorderRadius.all(Radius.circular(10))
              : const BorderRadius.all(Radius.circular(80)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            style: BorderStyle.solid,
            color: Color(0xFF439A97),
          ),
          borderRadius: widget.isTextArea != null && widget.isTextArea == true
              ? const BorderRadius.all(Radius.circular(10))
              : const BorderRadius.all(Radius.circular(80)),
        ),
        filled: true,
        fillColor: widget.backgroundColor,
        hintText: widget.hintText!,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        hintStyle: widget.hintTextStyle ??
            TextStyle(
              color: appColors.skyDark,
            ),
        counterText: widget.isTextArea != null && widget.isTextArea == true
            ? '${_enteredText.length.toString()}/${widget.maxLengthCharacters} ký tự'
            : null,
        counterStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: appColors.inkLighter),
        contentPadding: widget.contentPadding,
        focusColor: Colors.black12,
      ),
      validator: widget.validator,
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
                    Row(
                      children: [
                        Text(
                          widget.label as String,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        widget.isRequired == true
                            ? _requiredAsterisk()
                            : const SizedBox(
                                height: 0,
                              )
                      ],
                    ),
                    SizedBox(
                      height: widget.sizeBoxHeight!,
                    ),
                    widget.isTextArea != null
                        ? _inputTextFormField(context)
                        : _inputTextFormField(context),
                    SizedBox(
                      height: widget.marginBottom,
                    )
                  ])
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_inputTextFormField(context)]));
  }
}
