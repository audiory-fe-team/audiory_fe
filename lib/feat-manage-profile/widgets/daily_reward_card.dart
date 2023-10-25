import 'package:audiory_v0/models/streak/streak_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyRewardCard extends StatefulWidget {
  Streak streak;
  final Function(bool) handleReceive;
  DailyRewardCard(
      {super.key, required this.streak, required this.handleReceive});

  @override
  State<DailyRewardCard> createState() => _DailyRewardCardState();
}

class _DailyRewardCardState extends State<DailyRewardCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    String name = widget.streak.name;
    int amount = widget.streak.amount ?? 0;
    bool hasReceived = widget.streak.hasReceived;
    bool isLast = widget.streak.name.split(' ')[1] == '7' ? true : false;
    bool isGifted = widget.streak.name.split(' ')[1] == '3' ||
            widget.streak.name.split(' ')[1] == '7'
        ? true
        : false;

    return GestureDetector(
      onTap: () {
        setState(() {
          hasReceived = true;
        });
        widget.handleReceive(true);
      },
      child: SizedBox(
        width: isLast ? size.width / 2.4 : size.width / 4.8,
        height: 140,
        child: Column(
          children: [
            hasReceived
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: appColors.primaryBase, width: 1.5)),
                    height: 110,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: 0.5,
                          child: Image.asset(
                            isGifted == false
                                ? 'assets/images/coins.png'
                                : 'assets/images/gift.png',
                            scale: 0.8,
                          ),
                        ),
                        SizedBox(
                            child: Center(
                                child: Icon(
                          Icons.check,
                          color: appColors.primaryBase,
                          size: 24,
                        )))
                      ],
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: 110,
                    decoration: BoxDecoration(
                        color: appColors.skyLightest,
                        borderRadius: BorderRadius.circular(4)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            isGifted == false
                                ? 'assets/images/coins.png'
                                : 'assets/images/gift.png',
                            scale: 0.8,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            '+ $amount',
                            style: textTheme.titleMedium
                                ?.copyWith(color: appColors.inkBase),
                          ),
                        ]),
                  ),
            SizedBox(
              height: 30,
              child: Center(
                child: Text(
                  name,
                  style:
                      textTheme.titleMedium?.copyWith(color: appColors.inkBase),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
