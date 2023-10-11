import 'package:audiory_v0/constants/gifts.dart';
import 'package:audiory_v0/feat-read/widgets/chapter_item.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/tap_effect_wrapper.dart';
import 'package:audiory_v0/widgets/cards/donate_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DonateGiftModal extends HookWidget {
  final Story? story;

  const DonateGiftModal({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    final selectedItem = useState(GIFT_LIST[0]);
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Vật phẩm',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceEvenly,
                spacing: 4,
                runSpacing: 12,
                children: GIFT_LIST
                    .map((option) => TapEffectWrapper(
                        onTap: () {
                          selectedItem.value = option;
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: DonateItemCard(
                              gift: option,
                              selected: (selectedItem.value == option),
                            ))))
                    .toList(),
              ),
            )
          ]),
    ));
  }
}
