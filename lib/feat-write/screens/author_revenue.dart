import 'package:audiory_v0/feat-write/screens/layout/author_transaction_history.dart';
import 'package:audiory_v0/feat-write/screens/layout/revenue_app_bar.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:flutter/material.dart';

class AuthorRevenue extends StatelessWidget {
  const AuthorRevenue({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    Widget statsCard(
        {String title = '', dynamic num = 0, bool showDetail = false}) {
      return Container(
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(12),
        //     color: appColors.skyLightest),
        width: size.width / 2.3,
        // height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
        child: Column(
          children: [
            Text(
              '$num',
              style: textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: textTheme.titleSmall
                        ?.copyWith(color: appColors.inkLighter),
                  ),
                ),
                showDetail
                    ? SizedBox(
                        width: 17,
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                useRootNavigator: true,
                                barrierColor: Colors.transparent,
                                useSafeArea: true,
                                enableDrag: false,
                                context: context,
                                builder: (context) {
                                  return const AuthorRevenue();
                                });
                          },
                          child: Icon(
                            Icons.arrow_right_sharp,
                            color: appColors.inkLighter,
                            size: 16,
                          ),
                        ))
                    : const SizedBox(
                        height: 0,
                      ),
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: const RevenueCustomAppbar(),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.only(top: 16),
            width: double.infinity,
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Tổng thu nhập',
                    style: textTheme.titleLarge,
                  ),
                  Text(
                    formatNumber(50000),
                    style: textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: appColors.skyLightest,
                      borderRadius: BorderRadius.circular(12)),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      statsCard(title: 'Đang đóng băng', num: 0),
                      statsCard(title: 'Đã rút', num: 0),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Lịch sử thu nhập',
                  style: textTheme.titleMedium,
                ),
                Container(
                    height: size.height * 0.7,
                    child: const AuthorTransactionHistory())
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
