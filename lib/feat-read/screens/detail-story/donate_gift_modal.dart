import 'package:audiory_v0/models/gift/gift_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/repositories/gift_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/cards/donate_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fquery/fquery.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DonateGiftModal extends StatefulHookWidget {
  final Story? story;
  final dynamic coins;
  final Function(Gift, int) handleSendingGift;
  const DonateGiftModal(
      {super.key, this.story, this.coins = 0, required this.handleSendingGift});

  @override
  State<DonateGiftModal> createState() => _DonateGiftModalState();
}

class _DonateGiftModalState extends State<DonateGiftModal> {
  dynamic total = 0;
  @override
  Widget build(BuildContext context) {
    final giftsQuery =
        useQuery(['gifts'], () => GiftRepository().fetchAllGifts());

    var lists = giftsQuery.data ?? [];
    // lists.sort((a, b) => a.price?.compareTo(b.price ?? 0));

    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    final selectedItem = giftsQuery.data != null
        ? useState<dynamic>(lists.isEmpty ? null : lists[0])
        : null;
    final sizeController = useTextEditingController(text: "1");

    handleTotalCoins() {
      var count = int.parse(sizeController.value.text) ?? 0;
      var price = selectedItem!.value?.price ?? 0;

      setState(() {
        total = price * count;
      });
    }

    return Flexible(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Tặng vật phẩm',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      width: size.width / 3.7,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: appColors.skyLightest,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
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
                              child: Text(
                            '${widget.coins.toStringAsFixed(0)}',
                            style: textTheme.titleMedium
                                ?.copyWith(color: appColors.inkBase),
                          )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Skeletonizer(
                enabled: giftsQuery.isFetching,
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    spacing: 4,
                    runSpacing: 12,
                    children: lists
                        .map((option) => GestureDetector(
                            onTap: () {
                              selectedItem?.value = option;

                              handleTotalCoins();
                              // handleSendingGift(selectedItem?.value as Gift);
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: DonateItemCard(
                                  gift: option,
                                  selected: (selectedItem?.value == option),
                                ))))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child:
                          Text(total == 0 ? 'Tặng quà ngay' : 'Tổng $total xu'),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: appColors.skyLighter),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50))),
                            child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          int curVal =
                                              int.parse(sizeController.text);
                                          if (curVal <= 1) return;
                                          sizeController.text =
                                              (curVal - 1).toString();
                                          handleTotalCoins();
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
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
                                          int curVal =
                                              int.parse(sizeController.text);
                                          if (curVal >= 32) return;
                                          sizeController.text =
                                              (curVal + 1).toString();
                                          handleTotalCoins();
                                        },
                                        child: SvgPicture.asset(
                                          'assets/icons/plus.svg',
                                          width: 16,
                                          height: 16,
                                          color: appColors.primaryBase,
                                        )),
                                  ],
                                )),
                          ),
                          Container(
                            height: 40,
                            width: 75,
                            child: AppIconButton(
                              onPressed: () {
                                widget.handleSendingGift(selectedItem?.value,
                                    int.parse(sizeController.value.text));
                              },
                              title: 'Tặng',
                              textStyle: textTheme.titleLarge
                                  ?.copyWith(color: appColors.primaryBase),
                              bgColor: appColors.primaryLightest,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]),
      ),
    ));
  }
}
