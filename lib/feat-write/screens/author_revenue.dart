import 'package:audiory_v0/feat-write/screens/layout/author_transaction_history.dart';
import 'package:audiory_v0/feat-write/screens/layout/revenue_app_bar.dart';
import 'package:audiory_v0/models/frozen_diamond/frozen_diamond_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/repositories/author_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_date.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:audiory_v0/widgets/app_alert_dialog.dart';
import 'package:audiory_v0/widgets/custom_dialog.dart';
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
    double totalFrozen = 0;
    final revenueQuery = useQuery([
      'revenue',
    ], () => AuthorRepository().fetchRevenue());

    final frozenDiamondQuery = useQuery([
      'frozenDiamond',
    ], () => AuthorRepository().fetchFrozenDiamond());

    final userQuery = useQuery([
      'userById',
    ], () => AuthRepository().getMyUserById());
    useEffect(() {
      Map<String, dynamic> entryObject =
          revenueQuery.data?['analytics']?[0]?['values'] ?? {};

      for (var element in entryObject.entries) {
        totalRevenue += (int.tryParse('${element.value ?? 0}') ?? 0);
      }
    }, [revenueQuery]);

    useEffect(() {
      List<FrozenDiamond> list = frozenDiamondQuery.data ?? [];

      for (var element in list) {
        totalFrozen += (double.tryParse('${element.amount ?? 0}') ?? 0);
      }
    }, [frozenDiamondQuery]);

    Widget statsCard({String title = '', dynamic num = 0, bool isDia = false}) {
      List<FrozenDiamond> frozenList = frozenDiamondQuery.data ?? [];
      return GestureDetector(
        onTap: () {
          isDia == false && frozenList.isNotEmpty == true
              ? showDialog(
                  context: context,
                  builder: (context) {
                    String unfrozenDate =
                        appFormatDate(frozenList[0].unfrozenDate);

                    // List<Story> storyList= ;
                    return AppAlertDialog(
                      title: 'Thông báo',
                      customContent: frozenList.length == 1
                          ? Text(
                              '${formatDoubleNum(totalFrozen)} kim cương có thể rút về ví từ ngày $unfrozenDate ')
                          : SizedBox(
                              height: size.height * 0.27,
                              child: SingleChildScrollView(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                        frozenList.asMap().entries.map((e) {
                                      Story? story = e.value.story;
                                      String date = appFormatDate(
                                          frozenList[e.key].unfrozenDate);
                                      String total = formatDoubleNum(
                                          e.value.amount?.toDouble());
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Wrap(
                                          children: [
                                            RichText(
                                              textAlign: TextAlign.justify,
                                              text: TextSpan(
                                                text: '',
                                                style: textTheme.bodyMedium
                                                    ?.copyWith(),
                                                children: <TextSpan>[
                                                  const TextSpan(
                                                      text: 'Truyện '),
                                                  TextSpan(
                                                      text: '${story?.title}',
                                                      style: textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic)),
                                                  const TextSpan(
                                                      text: ' đã nhận được'),
                                                  TextSpan(
                                                      text: ' $total kim cương',
                                                      style: textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  TextSpan(
                                                      text:
                                                          '. Có thể rút về ví từ ngày $date '),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                      actionText: 'Tôi đã hiểu',
                      cancelButton: const SizedBox(height: 0),
                    );
                  })
              : null;
        },
        child: Container(
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
                                : formatDoubleNum(num),
                            style: textTheme.titleLarge,
                          )),
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Image.asset('assets/images/diamond.png',
                              width: 14),
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
            margin: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: appColors.skyLightest,
                      borderRadius: BorderRadius.circular(12)),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      statsCard(title: 'Đang đóng băng', num: totalFrozen),
                      statsCard(title: 'Có thể rút', num: 0, isDia: true),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Lịch sử thu nhập',
                    style: textTheme.titleMedium,
                  ),
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
