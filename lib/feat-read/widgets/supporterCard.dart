import 'package:flutter/material.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:intl/intl.dart';

class SupporterCard extends StatelessWidget {
  final int rank;
  final String name;
  final int score;
  final String image;
  const SupporterCard(
      {super.key,
      this.rank = 0,
      this.name = '',
      this.score = 0,
      this.image = ''});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final numberFormat =
        new NumberFormat.currency(symbol: '', decimalDigits: 0);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      width: double.maxFinite,
      child: rank <= 3
          ? Container(
              height: 48,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      // borderRadius: BorderRadius.circular(50.0),
                      child: rank == 1
                          ? Image.asset('assets/images/gold_badge.png',
                              width: 40.0, height: 40.0)
                          : rank == 2
                              ? Image.asset('assets/images/silver_badge.png',
                                  width: 40.0, height: 40.0)
                              : Image.asset('assets/images/bronze_badge.png',
                                  width: 40.0, height: 40.0),
                    ),
                    Container(
                      width: 230,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${name}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            '${numberFormat.format(score)} điểm',
                            style: TextStyle(
                                fontSize: 14, color: appColors.inkLighter),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      // borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset('assets/images/user-avatar.jpg',
                          width: 40.0, height: 40.0),
                    ),
                  ]),
            )
          : Container(
              height: 24,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: 40,
                        child: Text('${rank}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium)),
                    Container(
                      width: 230,
                      child: Text('${name}',
                          style: TextStyle(color: appColors.inkBase)),
                    ),
                    Text(
                      '${numberFormat.format(score)} điểm',
                      style: TextStyle(color: appColors.inkLighter),
                    ),
                  ]),
            ),
    );
  }
}
