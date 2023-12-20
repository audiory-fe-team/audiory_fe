import 'package:audiory_v0/feat-manage-profile/screens/wallet/withdraw_screen.dart';
import 'package:audiory_v0/feat-write/screens/author_revenue.dart';
import 'package:audiory_v0/feat-write/screens/layout/dashboard_app_bar.dart';
import 'package:audiory_v0/providers/global_me_provider.dart';
import 'package:audiory_v0/repositories/author_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:audiory_v0/widgets/buttons/tap_effect_wrapper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AuthorDashboard extends HookConsumerWidget {
  const AuthorDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final currentUser = ref.watch(globalMeProvider);

    int totalRead = 0;
    int totalVote = 0;
    int totalComment = 0;
    int totalDonation = 0;

    int totalRevenue = 0;
    final authorStasQuery = useQuery([
      'authorStats',
    ], () => AuthorRepository().fetchStatus());

    final readersQuery = useQuery([
      'readersQuery',
    ], () => AuthorRepository().fetchTopReaders());

    final rankingStoriesQuery = useQuery([
      'rankingStoriesDashboar',
    ], () => AuthorRepository().fetchTopStories());
    final revenueQuery = useQuery([
      'revenue',
    ], () => AuthorRepository().fetchRevenue());
    useEffect(() {
      totalRead = authorStasQuery.data['total_read'] ?? 0;
      totalVote = authorStasQuery.data['total_vote'] ?? 0;
      totalComment = authorStasQuery.data['total_comment'] ?? 0;
      totalDonation = authorStasQuery.data['total_donation'] ?? 0;
    }, [authorStasQuery]);

    useEffect(() {
      Map<String, dynamic> entryObject =
          revenueQuery.data?['analytics'][0]?['values'] ?? {};

      for (var element in entryObject.entries) {
        totalRevenue += (int.tryParse('${element.value ?? 0}') ?? 0);
      }
    }, [revenueQuery]);

    Widget statsCard(
        {String title = '', dynamic num = 0, bool showDetail = false}) {
      return GestureDetector(
        onTap: () {
          if (showDetail == true) {
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
          }
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: appColors.skyLightest),
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
        ),
      );
    }

    Widget storiesPieChart(data) {
      List list = data ?? [];

      int total = 0;
      for (var i = 0; i < list.length; i++) {
        total += (int.parse('${list[i]?['total_read'] ?? 0}'));
      }

      return list.isNotEmpty == true
          ? PieChart(
              PieChartData(
                startDegreeOffset: -90,
                sections: list.asMap().entries.map((entry) {
                  dynamic item = entry.value;
                  int percent = entry.value?['total_read'] ?? 0;
                  int index = entry.key;
                  return PieChartSectionData(
                    value: double.tryParse('$percent'),
                    color: index == 0
                        ? appColors.primaryDark
                        : index == 1
                            ? appColors.primaryLighter
                            : index == 2
                                ? appColors.skyLighter
                                : appColors.secondaryLightest,
                    showTitle: false,
                    badgeWidget: Container(
                        width: 40,
                        height: 20,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: appColors.inkBase,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: appColors.skyLightest, width: 0.5),
                        ),
                        child: Center(
                          child: Text(
                            '${((percent * 1.0 / total) * 100).toStringAsFixed(0)}%',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleSmall
                                ?.copyWith(color: appColors.skyLightest),
                          ),
                        )),
                    badgePositionPercentageOffset: 1,
                  );
                }).toList(),

                // read about it in the PieChartData section
              ),
              swapAnimationDuration:
                  const Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear, // Optional
            )
          : const Center(
              child: Text('Chưa có dữ liệu thống kê'),
            );
    }

    return Scaffold(
      appBar: const DashboardCustomAppbar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 24),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'Trung tâm số liệu',
                      style: textTheme.titleMedium,
                    ),
                  ),
                  Flexible(
                    child: TapEffectWrapper(
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            useRootNavigator: true,
                            barrierColor: Colors.transparent,
                            useSafeArea: true,
                            enableDrag: false,
                            context: context,
                            builder: (context) {
                              return const WithdrawScreen();
                            });
                      },
                      child: Text(
                        'Rút kim cương',
                        style: textTheme.bodySmall?.copyWith(
                            color: appColors.primaryBase,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                runAlignment: WrapAlignment.spaceBetween,
                alignment: WrapAlignment.spaceBetween,
                direction: Axis.horizontal,
                runSpacing: 12,
                children: [
                  statsCard(title: 'Lượt xem', num: formatNumber(totalRead)),
                  statsCard(
                      title: 'Lượt bình chọn', num: formatNumber(totalVote)),
                  statsCard(
                      title: 'Bình luận', num: formatNumber(totalComment)),
                  statsCard(
                      title: 'Người theo dõi',
                      num: formatNumber(
                          currentUser?.followers?.isNotEmpty == true
                              ? currentUser?.followers?.length ?? 0
                              : 0)),
                  statsCard(
                    title: 'Lượt tặng quà',
                    num: formatNumber(totalDonation),
                  ),
                  statsCard(
                      title: 'Tổng thu nhập',
                      num: formatNumber(totalRevenue),
                      showDetail: true),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16),
              width: double.infinity,
              child: Text(
                'Truyện có tương tác tốt',
                style: textTheme.titleMedium,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: size.width * 0.5,
                        child: storiesPieChart(rankingStoriesQuery.data)),
                    rankingStoriesQuery.data != null
                        ? Container(
                            height: 50,
                            child: Wrap(
                              runAlignment: WrapAlignment.spaceBetween,
                              alignment: WrapAlignment.spaceBetween,
                              direction: Axis.horizontal,
                              children: rankingStoriesQuery.data
                                  ?.asMap()
                                  ?.entries
                                  ?.map<Widget>((entry) {
                                dynamic item = entry?.value;
                                int index = entry?.key;
                                return Container(
                                  width: size.width / 2.2,
                                  height: 20,
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: Row(children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 6),
                                      height: 14,
                                      width: 14,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: index == 0
                                            ? appColors.primaryDark
                                            : index == 1
                                                ? appColors.primaryLighter
                                                : index == 2
                                                    ? appColors.skyLighter
                                                    : appColors
                                                        .secondaryLightest,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        item?['title'],
                                        style: textTheme.bodySmall,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    )
                                  ]),
                                );
                              }).toList(),
                            ),
                          )
                        : Text('Chưa có dữ liệu')
                  ],
                )),
            Container(
              padding: const EdgeInsets.only(top: 16),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'Người ủng hộ nổi bật',
                      style: textTheme.titleMedium,
                    ),
                  ),
                  // Flexible(
                  //   child: TapEffectWrapper(
                  //     onTap: () {
                  //       showModalBottomSheet(
                  //           isScrollControlled: true,
                  //           useRootNavigator: true,
                  //           barrierColor: Colors.transparent,
                  //           useSafeArea: true,
                  //           enableDrag: false,
                  //           context: context,
                  //           builder: (context) {
                  //             return const NewPurchaseScreen();
                  //           });
                  //     },
                  //     child: Text(
                  //       'Thêm',
                  //       style: textTheme.bodySmall?.copyWith(
                  //           color: appColors.primaryBase,
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            readersQuery.data?.length != 0
                ? SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration:
                          BoxDecoration(color: appColors.primaryLightest),
                      width: size.width * 0.9,
                      height: 35,
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 4),
                              width: size.width * 0.1,
                              child: Text(
                                'Hạng',
                                style: textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.5,
                              child: Text(
                                'Tên độc giả',
                                textAlign: TextAlign.start,
                                style: textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.3,
                              child: Text(
                                'Cống hiến',
                                style: textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                    ),
                  )
                : const SizedBox(
                    height: 0,
                  ),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              width: double.infinity,
              height: size.height * 0.4,
              child: readersQuery.data?.isNotEmpty == true
                  ? ListView.builder(
                      itemCount: readersQuery.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        dynamic reader = readersQuery.data[index];
                        return Container(
                          width: size.width * 0.9,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: appColors.skyLighter, width: 0.5),
                          ),
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: size.width * 0.1,
                                  child: Text(
                                    '${index + 1}',
                                    textAlign: TextAlign.center,
                                    style: textTheme.titleSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.5,
                                  child: Text(
                                    '${reader?['full_name']}',
                                    style: textTheme.titleMedium,
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${reader?['total_chapters_bought']} chương mua',
                                        style: textTheme.titleSmall?.copyWith(
                                            color: appColors.inkLighter),
                                      ),
                                      Text(
                                        '${formatNumber(reader?['total_donation'] ?? 0)} điểm quà',
                                        style: textTheme.titleSmall?.copyWith(
                                            color: appColors.inkLighter),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        );
                      })
                  : const Center(child: Text('Chưa có độc giả ủng hộ')),
            )
          ]),
        ),
      ),
    );
  }
}
