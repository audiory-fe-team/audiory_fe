import 'package:audiory_v0/constants/theme_options.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingModel extends HookConsumerWidget {
  final Function() onChangeStyle;

  const SettingModel({super.key, required this.onChangeStyle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedOption = useState(0);
    final showCommentByParagraph = useState(false);
    final isKaraoke = useState(true);
    final setTimer = useState(false);
    final audioSpeed = useState<double>(1);

    final notifier = ref.watch(themeNotifierProvider);

    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final sizeController = useTextEditingController(text: '18');
    final timerController = useTextEditingController(text: '10');

    setPreference() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('fontSize', int.tryParse(sizeController.text) ?? 18);
      await prefs.setBool(
          'showCommentByParagraph', showCommentByParagraph.value);
      await prefs.setBool('isKaraoke', isKaraoke.value);
      await prefs.setInt('themeOption', selectedOption.value);
      await prefs.setDouble('audioSpeed', audioSpeed.value);
      if (selectedOption.value <= 1) {
        notifier.setTheme(
            selectedOption.value == 1 ? ThemeMode.dark : ThemeMode.light);
        return;
      }
      if (setTimer.value) {
        await prefs.setInt('timer', int.tryParse(timerController.text) ?? 10);
      }
    }

    syncPreference() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      selectedOption.value = prefs.getInt('themeOption') ?? 0;
      sizeController.text = (prefs.getInt('fontSize') ?? 18).toString();
      audioSpeed.value = prefs.getDouble('audioSpeed') ?? 1;
      showCommentByParagraph.value =
          prefs.getBool('showCommentByParagraph') ?? true;
      isKaraoke.value = prefs.getBool('isKaraoke') ?? true;
    }

    useEffect(() {
      syncPreference();
    }, []);

    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: appColors.skyBase,
                width: 0.5,
                style: BorderStyle.solid,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 20),
              Text(
                'Cài đặt',
                style: textTheme.headlineSmall,
                overflow: TextOverflow.ellipsis,
              ),
              IconButton(
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close_outlined, size: 18)),
            ],
          )),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              //Audio setting
              Row(children: [
                Expanded(
                    child: Container(
                  width: double.infinity,
                  color: appColors.skyBase,
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                )),
                Text(
                  'Audio',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(width: 4),
                Icon(Icons.graphic_eq_rounded,
                    size: 18, color: appColors.secondaryBase),
                Expanded(
                    child: Container(
                  width: double.infinity,
                  color: appColors.skyBase,
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                )),
              ]),
              const SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Tốc độ',
                        style: Theme.of(context).textTheme.titleLarge,
                      )),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      SizedBox(
                          width: 30,
                          child: Text('${audioSpeed.value}',
                              style: textTheme.titleMedium)),
                      Expanded(
                          child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                overlayShape: SliderComponentShape.noOverlay,
                                trackHeight: 4,
                                activeTrackColor: appColors.primaryBase,
                                inactiveTrackColor: appColors.primaryLightest,
                                thumbColor: appColors.primaryBase,
                                overlayColor: appColors.primaryBase,
                                tickMarkShape: SliderTickMarkShape.noTickMark,
                                thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 8),
                              ),
                              child: Slider(
                                value: audioSpeed.value,
                                max: 2,
                                divisions: 8,
                                label: audioSpeed.value.toString(),
                                onChanged: (double value) {
                                  audioSpeed.value = value;
                                },
                              ))),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hẹn giờ',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: setTimer.value,
                          onChanged: (value) {
                            setTimer.value = value ?? false;
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          fillColor: MaterialStatePropertyAll(
                            appColors.primaryBase,
                          ),
                        ),
                      ]),
                  const SizedBox(height: 12),
                  if (setTimer.value)
                    SizedBox(
                      width: 30,
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.bodyMedium,
                        controller: timerController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(0),
                          isDense: true,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              //Display setting
              Row(children: [
                Expanded(
                    child: Container(
                  width: double.infinity,
                  color: appColors.skyBase,
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                )),
                Text(
                  'Hiển thị',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(width: 4),
                Icon(Icons.visibility_rounded,
                    size: 18, color: appColors.secondaryBase),
                Expanded(
                    child: Container(
                  width: double.infinity,
                  color: appColors.skyBase,
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                )),
              ]),
              const SizedBox(height: 16),
              //Note: Background color
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
                      ...THEME_OPTIONS.asMap().entries.map((entry) {
                        int idx = entry.key;
                        Map<String, Color> val = entry.value;
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
                                      color: val['bgColor'],
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
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              //NOTE: Font size
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  isDense: true,
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
                        )),
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
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Tự động cuộn theo audio',
                              style: Theme.of(context).textTheme.bodyMedium),
                          Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: isKaraoke.value,
                            onChanged: (value) {
                              isKaraoke.value = value ?? false;
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
                        onPressed: () async {
                          await setPreference();
                          onChangeStyle();
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
      )
    ]);
  }
}
