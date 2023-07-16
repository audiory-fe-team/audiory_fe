import 'package:audiory_v0/layout/bottom_bar.dart';
import 'package:audiory_v0/screens/reading/bottom_bar.dart';
import 'package:audiory_v0/screens/reading/mock_data.dart';
import 'package:audiory_v0/screens/reading/reading_top_bar.dart';
import 'package:audiory_v0/theme/theme_constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReadingScreen extends StatelessWidget {
  const ReadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReadingTopBar(),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
              color: Colors.white,
              child: ListView(
                children: [
                  const SizedBox(height: 24),
                  const ReadingScreenHeader(
                    num: 1,
                    name: 'Câu chuyện về cánh cửa',
                    view: 41834,
                    vote: 648,
                    comment: 19,
                  ),
                  const SizedBox(height: 24),
                  ChapterContent(content: CHAPTER_DETAIL.content),
                  SizedBox(
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ActionButton(
                            title: 'Bình chọn',
                            iconName: 'heart',
                            onPressed: () {}),
                        const SizedBox(width: 12),
                        ActionButton(
                            title: 'Tặng quà',
                            iconName: 'gift',
                            onPressed: () {}),
                        const SizedBox(width: 12),
                        ActionButton(
                            title: 'Chia sẻ',
                            iconName: 'share',
                            onPressed: () {}),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 38,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChapterNavigateButton(
                          onPressed: () => {},
                          disabled: true,
                        ),
                        const SizedBox(width: 12),
                        ChapterNavigateButton(
                          next: true,
                          onPressed: () => {},
                        ),
                      ],
                    ),
                  ),
                ],
              ))),
      bottomNavigationBar: const ReadingBottomBar(),
    );
  }
}

// class SettingModal extends StatelessWidget {
//   const SettingModal({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class ChapterNavigateButton extends StatelessWidget {
  final bool next;
  final bool disabled;
  final Function onPressed;
  const ChapterNavigateButton(
      {super.key,
      this.next = false,
      required this.onPressed,
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Expanded(
        child: FilledButton(
      onPressed: () {
        if (!disabled) onPressed();
      },
      style: FilledButton.styleFrom(
          backgroundColor:
              disabled ? appColors.skyLighter : appColors.primaryBase,
          minimumSize: Size.zero, // Set this
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          alignment: Alignment.center // and this
          ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          !next
              ? SvgPicture.asset(
                  'assets/icons/left-arrow.svg',
                  width: 12,
                  height: 12,
                  color: Colors.white,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            width: 4,
          ),
          Text(
            next ? 'Chương sau' : 'Chương trước',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(
            width: 4,
          ),
          next
              ? SvgPicture.asset(
                  'assets/icons/right-arrow.svg',
                  width: 12,
                  height: 12,
                  color: Colors.white,
                )
              : const SizedBox.shrink(),
        ],
      ),
    ));
  }
}

class ActionButton extends StatelessWidget {
  final String title;
  final String iconName;
  final Function onPressed;

  const ActionButton(
      {super.key,
      required this.title,
      required this.iconName,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return FilledButton(
      onPressed: () {},
      style: FilledButton.styleFrom(
          backgroundColor: appColors.primaryLightest,
          minimumSize: Size.zero, // Set this
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          alignment: Alignment.center // and this
          ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/' + iconName + '.svg',
            width: 12,
            height: 12,
            color: appColors.primaryBase,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w600, color: appColors.primaryBase),
          )
        ],
      ),
    );
  }
}

class ChapterContent extends StatelessWidget {
  final List<String> content;
  const ChapterContent({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: content
          .map((para) => Column(children: [
                Text(para, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 24)
              ]))
          .toList(),
    );
  }
}

class ReadingScreenHeader extends StatelessWidget {
  final int num;
  final String name;
  final int view;
  final int vote;
  final int comment;

  const ReadingScreenHeader(
      {super.key,
      required this.num,
      required this.name,
      required this.view,
      required this.vote,
      required this.comment});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Column(children: [
      Text('Chương ' + num.toString() + ":",
          style: Theme.of(context).textTheme.bodyLarge),
      Text(name, style: Theme.of(context).textTheme.bodyLarge, softWrap: true),
      const SizedBox(height: 12),
      Container(
        height: 24,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/eye.svg',
                width: 14,
                height: 14,
                color: appColors.primaryBase,
              ),
              const SizedBox(width: 4),
              Text(
                view.toString(),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontStyle: FontStyle.italic),
              )
            ],
          ),
          const SizedBox(width: 24),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/heart.svg',
                width: 14,
                height: 14,
                color: appColors.primaryBase,
              ),
              const SizedBox(width: 4),
              Text(
                vote.toString(),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontStyle: FontStyle.italic),
              )
            ],
          ),
          const SizedBox(width: 24),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/message-box-circle.svg',
                width: 14,
                height: 14,
                color: appColors.primaryBase,
              ),
              const SizedBox(width: 4),
              Text(
                comment.toString(),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontStyle: FontStyle.italic),
              )
            ],
          ),
        ]),
      )
    ]);
  }
}
