import 'package:audiory_v0/models/Gift.dart';
import 'package:flutter/material.dart';

import '../../theme/theme_constants.dart';

class DonateItemCard extends StatelessWidget {
  final Gift gift;
  final bool selected;
  const DonateItemCard({super.key, required this.gift, this.selected = false});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Container(
      decoration: BoxDecoration(
        color:
            (selected == true ? appColors.primaryBase : appColors.skyLightest),
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
          child: Image.asset(gift.imgUrl ?? '', width: 70.0, height: 70.0)),
    );
  }
}
