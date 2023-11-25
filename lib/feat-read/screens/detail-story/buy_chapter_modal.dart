import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BuyChapterModal extends StatefulHookWidget {
  final Chapter chapter;
  final int? paywalledChaptersCount;
  final Function() handleBuyStory;
  final Function(String) handleBuyChapter;
  const BuyChapterModal(
      {super.key,
      this.paywalledChaptersCount,
      required this.chapter,
      required this.handleBuyStory,
      required this.handleBuyChapter});

  @override
  State<BuyChapterModal> createState() => _BuyChapterModalState();
}

class _BuyChapterModalState extends State<BuyChapterModal> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    final userQuery = useQuery([
      'userById',
    ], () => AuthRepository().getMyUserById());

    int totalBuyStory =
        widget.paywalledChaptersCount! * (widget.chapter.price ?? 1);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: size.width / 3.75,
            height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: appColors.skyLightest,
                borderRadius: const BorderRadius.all(Radius.circular(50))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: GestureDetector(
                  child: Image.asset(
                    'assets/images/coin.png',
                    width: 30,
                    height: 30,
                  ),
                )),
                Flexible(
                  child: Skeletonizer(
                    enabled: userQuery.isFetching,
                    child: Text(
                      '${userQuery.data?.wallets?[0].balance}' ?? '0',
                      style: textTheme.titleLarge
                          ?.copyWith(color: appColors.inkBase),
                    ),
                  ),
                ),
                Flexible(
                    child: GestureDetector(
                  onTap: () => {},
                  child: const Icon(
                    Icons.add,
                    size: 22,
                  ),
                )),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.chapter.title ?? '', style: textTheme.titleLarge),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 3,
                      child: GestureDetector(
                        child: Image.asset(
                          'assets/images/coin.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Text(
                        '${widget.chapter.price} ',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: appColors.inkLighter),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: size.width - 32,
                  child: AppIconButton(
                    onPressed: () async {
                      widget.handleBuyChapter(widget.chapter.id);
                    },
                    title: 'Mở khóa chương',
                    textStyle: textTheme.titleMedium
                        ?.copyWith(color: appColors.skyLightest),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                widget.paywalledChaptersCount! >= 5
                    ? SizedBox(
                        width: size.width - 32,
                        child: AppIconButton(
                          title:
                              'Mua cả truyện với ${(totalBuyStory * 0.8).round()} xu ( tiết kiệm ${(totalBuyStory * 0.2).round()} xu)',
                          textStyle: textTheme.titleMedium
                              ?.copyWith(color: appColors.primaryBase),
                          isOutlined: true,
                          bgColor: appColors.skyLightest,
                          onPressed: () {
                            widget.handleBuyStory();
                          },
                        ),
                      )
                    : SizedBox(
                        width: size.width - 32,
                        child: AppIconButton(
                          title:
                              'Mua cả truyện với ${(totalBuyStory).round()} xu',
                          textStyle: textTheme.titleMedium
                              ?.copyWith(color: appColors.primaryBase),
                          isOutlined: true,
                          bgColor: appColors.skyLightest,
                          onPressed: () {
                            widget.handleBuyStory();
                          },
                        ),
                      )
              ],
            ),
          )
        ]);
  }
}
