import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/theme_constants.dart';

class DonateItemCard extends StatefulWidget {
  final String name;
  const DonateItemCard({super.key, this.name = ''});

  @override
  State<DonateItemCard> createState() => _DonateItemCardState();
}

class _DonateItemCardState extends State<DonateItemCard> {
  bool selected = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool selected = false;

    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return GestureDetector(
      onTap: () => () {
        setState(() {
          selected = true;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: (selected == true
                ? appColors.primaryBase
                : appColors.skyLightest)),
        child: ClipRRect(
            child: Image.asset('assets/images/gift_${widget.name}.png',
                width: 70.0, height: 70.0)),
      ),
    );
  }
}
