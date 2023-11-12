import 'package:audiory_v0/feat-manage-profile/widgets/daily_reward_card.dart';
import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/enums/TransactionType.dart';
import 'package:audiory_v0/models/streak/streak_model.dart';
import 'package:audiory_v0/models/transaction/transaction_model.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/repositories/transaction_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_date.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:fquery/fquery.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DailyRewardsScreen extends StatefulHookWidget {
  final AuthUser? currentUser;
  const DailyRewardsScreen({super.key, this.currentUser});

  @override
  State<DailyRewardsScreen> createState() => _DailyRewardsScreenState();
}

class _DailyRewardsScreenState extends State<DailyRewardsScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final transactionsQuery = useQuery(
        ['myDailyRewardTransactions'],
        () => TransactionRepository.fetchMyTransactions(
            type: TransactionType.DAILY_REWARD, pageSize: 10000));

    print(transactionsQuery.data);
    final userStreakQuery =
        useQuery(['userStreak'], () => AuthRepository().getMyStreak());
    print('streak');
    print(userStreakQuery.data);
    handleReceiveReward(bool isToday) async {
      try {
        await AuthRepository().receiveReward();

        AppSnackBar.buildTopSnackBar(
            context, 'Nhận thưởng thành công', null, SnackBarType.success);
        userStreakQuery.refetch();
      } catch (e) {
        AppSnackBar.buildTopSnackBar(
            context, 'Bạn đã nhận cho hôm nay rồi', null, SnackBarType.info);
      }
    }

    validFormatDateForParsing(String? date) {
      DateTime? newtime = DateFormat("yyyy-MM-dd").parse(date as String);
      return newtime.toString();
    }

    Widget transactionCard(Transaction? transaction) {
      final containerSize = double.infinity - 32;

      TransactionType transactionType = TransactionType.values.byName(
          transaction?.transactionType?.toUpperCase() ?? 'DAILY_REWARD');
      return SizedBox(
        height: 75,
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        // decoration: BoxDecoration(
        //     color: appColors.skyLightest,
        //     borderRadius: const BorderRadius.all(Radius.circular(16)),
        //     boxShadow: [
        //       BoxShadow(
        //         color: appColors.skyBase.withOpacity(0.55),
        //         spreadRadius: 3,
        //         blurRadius: 6,
        //         offset: const Offset(0, 3), // changes position of shadow
        //       ),
        //     ]),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: containerSize * 0.15,
                child: Container(
                  width: containerSize * 0.15,
                  height: containerSize * 0.15,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: transactionType.displayBgColor.withOpacity(0.2)),
                  child: Transform.rotate(
                    angle: 0,
                    child: Icon(
                      transactionType.displayIcon,
                      color: transactionType.displayIconColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: containerSize * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          transactionType.displayText,
                          style: textTheme.titleMedium,
                        ),
                        Text(
                          appFormatDate(transaction?.createdDate),
                          style: textTheme.bodyMedium
                              ?.copyWith(color: appColors.inkLight),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                width: containerSize * 0.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '',
                      style: textTheme.titleLarge,
                    ),
                    Text(
                      '${transactionType.displayTrend} ${transaction?.totalPriceAfterCommission} xu',
                      style: textTheme.titleMedium
                          ?.copyWith(color: appColors.inkDarkest),
                    ),
                  ],
                ),
              ),
            ]),
      );
    }

    return Scaffold(
      backgroundColor: appColors.primaryLightest,
      appBar: CustomAppBar(
        title: Text(
          'Nhận thưởng hàng ngày',
          style: textTheme.headlineMedium?.copyWith(color: appColors.inkBase),
        ),
      ),
      body: Column(children: [
        Flexible(
            child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              margin: EdgeInsets.only(top: size.height * 0.2),
              height: size.height * 0.65,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: SizedBox(
                height: size.height,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Tổng xu',
                          style: textTheme.bodyMedium
                              ?.copyWith(color: appColors.inkBase),
                        ),
                        Skeletonizer(
                          enabled: transactionsQuery.isFetching,
                          child: Text(
                            '${transactionsQuery.data?.length}',
                            style: textTheme.headlineLarge?.copyWith(
                                color: appColors.inkBase, fontSize: 50),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: size.height * 0.08),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Skeletonizer(
                                enabled: userStreakQuery.isFetching,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'Đã nhận thưởng',
                                        style: textTheme.headlineSmall
                                            ?.copyWith(
                                                color: appColors.inkBase),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        ' ${userStreakQuery.data?.where((e) => e.hasReceived == true).length ?? 0} ngày liên tiếp',
                                        style: textTheme.headlineSmall
                                            ?.copyWith(
                                                color: appColors.primaryBase),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Điểm danh 7 ngày liên tục để nhận quà khủng',
                                style: textTheme.bodyMedium
                                    ?.copyWith(color: appColors.inkBase),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: [...userStreakQuery.data ?? []]
                                .asMap()
                                .entries
                                .map((e) {
                              Streak streak = e.value;
                              return DailyRewardCard(
                                streak: streak,
                                handleReceive: (isToday) {
                                  handleReceiveReward(isToday);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    'Lịch sử nhận thưởng ${transactionsQuery.data?.length}',
                                    style: textTheme.headlineSmall
                                        ?.copyWith(color: appColors.inkDarkest),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    'Xem thêm',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: appColors.primaryDark,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              height: size.height * 0.41,
                              child: Skeletonizer(
                                enabled: transactionsQuery.isFetching,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      transactionsQuery.data?.length ?? 0,
                                  itemBuilder: (context, i) {
                                    print(transactionsQuery.data?[i]);
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: transactionCard(
                                          transactionsQuery.data?[i]),
                                    );
                                  },
                                  // children: List.generate(
                                  //     transactionsQuery.data?.length ?? 0,
                                  //     (index) {
                                  //   transactionsQuery.data?.sort((a, b) {
                                  //     //sorting in ascending order
                                  //     return DateTime.parse(
                                  //                 validFormatDateForParsing(
                                  //                     a.createdDate))
                                  //             .isBefore(DateTime.parse(
                                  //                 validFormatDateForParsing(
                                  //                     b.createdDate)))
                                  //         ? 1
                                  //         : -1;
                                  //   });
                                  //   return Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         vertical: 8.0),
                                  //     child: transactionCard(transactionsQuery
                                  //         .data?[index] as Transaction),
                                  //   );
                                  // }).toList(),
                                ),
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
              ),
            ),
          ],
        ))
      ]),
    );
  }
}
