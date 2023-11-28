import 'package:audiory_v0/models/paragraph/paragraph_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContentModerationDialog extends StatefulWidget {
  final List<Paragraph>? paragraphs;
  const ContentModerationDialog({super.key, required this.paragraphs});

  @override
  State<ContentModerationDialog> createState() =>
      _ContentModerationDialogState();
}

class _ContentModerationDialogState extends State<ContentModerationDialog> {
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final paragraphs = widget.paragraphs ?? [];
    return Container(
      height: size.height,
      child: Scaffold(
        appBar: CustomAppBar(title: Text('Chi tiết vi phạm')),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      color: appColors.skyLighter,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    'Đoạn văn được tô đậm là đoạn bị vi phạm',
                    style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Container(
                  width: size.width - 32,
                  height: size.height,
                  padding: EdgeInsets.only(bottom: 30),
                  child: ListView.builder(
                      itemCount: paragraphs.length,
                      itemBuilder: (BuildContext context, int index) {
                        Paragraph para = paragraphs[index];
                        bool isMature =
                            para.contentModeration?.isMature ?? false;
                        bool isReactionary =
                            para.contentModeration?.isReactionary ?? false;
                        return Container(
                          margin: EdgeInsets.only(bottom: 8),
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: isMature || isReactionary
                                  ? appColors.secondaryLight
                                  : Colors.transparent),
                          child: Text(
                            para.content ?? '',
                            textAlign: TextAlign.justify,
                            style: textTheme.bodyMedium?.copyWith(
                                color: isMature || isReactionary
                                    ? appColors.skyLightest
                                    : appColors.inkBase),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
            width: size.width - 32,
            child: AppIconButton(
              title: 'Tôi đã hiểu',
              textStyle:
                  textTheme.bodySmall?.copyWith(color: appColors.skyLightest),
              onPressed: () {
                context.pop();
                context.pop();
              },
            )),
      ),
    );
  }
}
