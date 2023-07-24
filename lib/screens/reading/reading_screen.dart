import 'package:audiory_v0/layout/bottom_bar.dart';
import 'package:audiory_v0/models/Chapter.dart';
import 'package:audiory_v0/models/Paragraph.dart';
import 'package:audiory_v0/screens/reading/bottom_bar.dart';
import 'package:audiory_v0/screens/reading/reading_top_bar.dart';
import 'package:audiory_v0/services/chapter.dart';
import 'package:audiory_v0/theme/theme_constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReadingScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final chapter = useState<Chapter?>(null);
    final chapterService = ChapterServices();

    final _bgColor = useState(Colors.white);
    final _fontSize = useState(16);
    final _showCommentByParagraph = useState(true);

    void _changeStyle(
        [Color? bgColor, int? fontSize, bool? showCommentByParagraph]) {
      _bgColor.value = bgColor ?? _bgColor.value;
      _fontSize.value = fontSize ?? _fontSize.value;
      _showCommentByParagraph.value =
          showCommentByParagraph ?? _showCommentByParagraph.value;
    }

    useEffect(() {
      chapterService
          .fetchChapterDetail("45395bae-1dac-11ee-abe7-e0d4e8a18075")
          .then((value) {
        chapter.value = value;
      }).catchError(() {});
    }, []);

    if (chapter.value == null) return CircularProgressIndicator();

    return Scaffold(
      backgroundColor: _bgColor.value,
      appBar: const ReadingTopBar(),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
              child: ListView(
            children: [
              const SizedBox(height: 24),
              ReadingScreenHeader(
                num: 1,
                name: 'Câu chuyện về cánh cửa',
                view: chapter.value?.read_count ?? 0,
                vote: chapter.value?.vote_count ?? 0,
                comment: chapter.value?.comment_count ?? 0,
              ),
              const SizedBox(height: 24),
              ChapterContent(
                content: chapter.value?.paragraphs ?? [],
                fontSize: _fontSize.value,
              ),
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
                        title: 'Tặng quà', iconName: 'gift', onPressed: () {}),
                    const SizedBox(width: 12),
                    ActionButton(
                        title: 'Chia sẻ', iconName: 'share', onPressed: () {}),
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
              const SizedBox(height: 24),
            ],
          ))),
      bottomNavigationBar: ReadingBottomBar(
        changeStyle: _changeStyle,
      ),
    );
  }
}

class SettingModelUseHooks extends HookWidget {
  final Function([Color? bgColor, int? fontSize, bool? showCommentByParagraph])
      changeStyle;

  const SettingModelUseHooks({super.key, required this.changeStyle});

  @override
  Widget build(BuildContext context) {
    final _selectedOption = useState(0);
    final _fontSize = useState(16);
    final _showCommentByParagraph = useState(false);

    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final List<Color> DEFAULT_OPTION = [
      appColors.skyLightest,
      appColors.inkBase,
      appColors.primaryLightest,
    ];

    final sizeController = useTextEditingController(text: "16");

    useEffect(() {}, [_selectedOption, _fontSize]);

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Cài đặt',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            //Note: Backgronud color
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    child: Text(
                      'Màu trang',
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                const SizedBox(height: 12),
                //Note:Background colors option
                Row(
                  children: [
                    ...DEFAULT_OPTION.asMap().entries.map((entry) {
                      int idx = entry.key;
                      Color val = entry.value;
                      return GestureDetector(
                          onTap: () {
                            _selectedOption.value = idx;
                          },
                          child: Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: val,
                                    shape: BoxShape.circle,
                                    border: _selectedOption.value == idx
                                        ? Border.all(
                                            color: appColors.primaryBase,
                                            width: 2,
                                            strokeAlign:
                                                BorderSide.strokeAlignOutside)
                                        : null,
                                  ))));
                    }).toList(),
                    GestureDetector(
                        onTap: () {},
                        child: Stack(
                          children: [
                            Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: appColors.primaryBase,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                    child: SvgPicture.asset(
                                  'assets/icons/plus.svg',
                                  color: Colors.white,
                                  width: 16,
                                  height: 16,
                                ))),
                          ],
                        )),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            //NOTE: Font size
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    child: Text(
                      'Cỡ chữ',
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: appColors.skyLighter),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Expanded(
                          child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () {
                                int curVal = int.parse(sizeController.text);
                                if (curVal <= 10) return;
                                sizeController.text = (curVal - 1).toString();
                              },
                              child: SvgPicture.asset(
                                'assets/icons/remove.svg',
                                width: 16,
                                height: 16,
                                color: appColors.skyBase,
                              )),
                          const SizedBox(width: 4),
                          Container(
                            width: 30,
                            child: TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: Theme.of(context).textTheme.bodyMedium,
                              controller: sizeController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(0),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          InkWell(
                              onTap: () {
                                int curVal = int.parse(sizeController.text);
                                if (curVal >= 32) return;
                                sizeController.text = (curVal + 1).toString();
                              },
                              child: SvgPicture.asset(
                                'assets/icons/plus.svg',
                                width: 16,
                                height: 16,
                                color: appColors.primaryBase,
                              )),
                        ],
                      ))),
                )
              ],
            ),
            const SizedBox(height: 16),
            //NOTE: Other settings
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    child: Text(
                      'Cài đặt khác',
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Hiện bình luận theo đoạn',
                            style: Theme.of(context).textTheme.bodyMedium),
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: _showCommentByParagraph.value,
                          onChanged: (value) {
                            _showCommentByParagraph.value = value ?? false;
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          fillColor: MaterialStatePropertyAll(
                            appColors.primaryBase,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
            const SizedBox(height: 16),
            Row(mainAxisSize: MainAxisSize.max, children: [
              Expanded(
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          side: BorderSide(
                            color: appColors.primaryBase,
                            width: 1,
                          )),
                      child: Text(
                        'Đặt lại',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: appColors.primaryBase),
                      ))),
              const SizedBox(width: 20),
              Expanded(
                  child: FilledButton(
                      onPressed: () {
                        changeStyle(DEFAULT_OPTION[_selectedOption.value],
                            _fontSize.value, _showCommentByParagraph.value);
                        Navigator.pop(context);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: appColors.primaryBase,
                        padding: EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      child: Text(
                        'Áp dụng',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
                      ))),
            ])
          ],
        ),
      ),
    );
  }
}

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
  final List<Paragraph> content;
  final int fontSize;
  const ChapterContent(
      {super.key, required this.content, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: content
          .map((para) => Column(children: [
                Text(para.content,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: fontSize.toDouble())),
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
