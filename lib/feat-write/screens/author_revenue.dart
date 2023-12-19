import 'package:audiory_v0/feat-write/screens/layout/author_transaction_history.dart';
import 'package:audiory_v0/feat-write/screens/layout/revenue_app_bar.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/repositories/author_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AuthorRevenue extends HookWidget {
  const AuthorRevenue({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    int totalRevenue = 0;
    final revenueQuery = useQuery([
      'revenue',
    ], () => AuthorRepository().fetchRevenue());

    final userQuery = useQuery([
      'userById',
    ], () => AuthRepository().getMyUserById());
    useEffect(() {
      Map<String, dynamic> entryObject =
          revenueQuery.data?['analytics'][0]?['values'] ?? {};

      for (var element in entryObject.entries) {
        totalRevenue += (int.tryParse('${element.value ?? 0}') ?? 0);
      }
    }, [revenueQuery]);

    Widget statsCard({String title = '', dynamic num = 0, bool isDia = false}) {
      return Container(
        width: size.width / 2.2,
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
        child: Column(
          children: [
            Skeletonizer(
              enabled: userQuery.isFetching,
              child: Container(
                width: size.width / 2.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        flex: 2,
                        child: Text(
                          isDia
                              ? '${double.tryParse(userQuery.data?.wallets?[1].balance.toString() ?? '0')?.toStringAsFixed(1)}'
                              : '0',
                          style: textTheme.titleLarge,
                        )),
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child:
                            Image.asset('assets/images/diamond.png', width: 14),
                      ),
                    ),
                  ],
                ),
              ),
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
                    '${formatNumberWithSeperator(totalRevenue)} đ',
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
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      statsCard(title: 'Đang đóng băng', num: 0),
                      statsCard(title: 'Có thể rút', num: 0, isDia: true),
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
