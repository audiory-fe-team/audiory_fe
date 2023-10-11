import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingModel extends HookWidget {
  final Function([Color? bgColor, int? fontSize, bool? showCommentByParagraph])
      changeStyle;

  const SettingModel({super.key, required this.changeStyle});

  @override
  Widget build(BuildContext context) {
    final selectedOption = useState(0);
    final fontSize = useState(16);
    final showCommentByParagraph = useState(false);

    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final List<Color> DEFAULT_OPTION = [
      appColors.skyLightest,
      appColors.inkBase,
      appColors.primaryLightest,
    ];

    final sizeController = useTextEditingController(text: "16");

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                SizedBox(
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
                            selectedOption.value = idx;
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: val,
                                    shape: BoxShape.circle,
                                    border: selectedOption.value == idx
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
                SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Cỡ chữ',
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: appColors.skyLighter),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50))),
                  child: Padding(
                      padding: const EdgeInsets.all(5),
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
                          SizedBox(
                            width: 30,
                            child: TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: Theme.of(context).textTheme.bodyMedium,
                              controller: sizeController,
                              decoration: const InputDecoration(
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
                SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Cài đặt khác',
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Hiện bình luận theo đoạn',
                            style: Theme.of(context).textTheme.bodyMedium),
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: showCommentByParagraph.value,
                          onChanged: (value) {
                            showCommentByParagraph.value = value ?? false;
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
                          padding: const EdgeInsets.all(12),
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
                        changeStyle(DEFAULT_OPTION[selectedOption.value],
                            fontSize.value, showCommentByParagraph.value);
                        Navigator.pop(context);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: appColors.primaryBase,
                        padding: const EdgeInsets.all(12),
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
