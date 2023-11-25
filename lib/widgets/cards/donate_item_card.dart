import 'package:audiory_v0/models/gift/gift_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../theme/theme_constants.dart';

class DonateItemCard extends StatelessWidget {
  final Gift gift;
  final bool selected;
  const DonateItemCard({super.key, required this.gift, this.selected = false});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
            width: 2.5,
            color: selected == true
                ? appColors.primaryBase
                : appColors.skyLightest),
        color: (selected == true
            ? appColors.primaryLightest
            : appColors.skyLightest),
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        child: Lottie.network(gift.imageUrl ?? '',
            errorBuilder: (context, error, stackTrace) => LottieBuilder.asset(
                  'assets/gifs/gif-rose.json',
                  width: 70,
                  height: 70,
                ),
            width: 70,
            height: 70),
      ),
    );
  }
}
