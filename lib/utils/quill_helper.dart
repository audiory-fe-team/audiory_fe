import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

appQuillToolbarConfig(BuildContext context) {
  final AppColors appColors = Theme.of(context).extension<AppColors>()!;

  return QuillToolbarConfigurations(
      embedButtons: FlutterQuillEmbeds.toolbarButtons(videoButtonOptions: null),
      color: appColors.skyLightest,
      showAlignmentButtons: false,
      showCodeBlock: false,
      showBackgroundColorButton: false,
      showIndent: false,
      showInlineCode: false,
      showLink: false,
      showListCheck: false,
      showQuote: false,
      showListBullets: false,
      showSubscript: false,
      showSuperscript: false,
      showStrikeThrough: false,
      showSmallButton: false,
      showColorButton: false,
      showDividers: false,
      showClearFormat: false,
      // showDirection: false,
      showHeaderStyle: false,
      showFontFamily: false,
      showFontSize: false,
      showListNumbers: false,
      decoration: BoxDecoration(color: appColors.skyLightest));
}
