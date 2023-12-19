import 'dart:math';

import 'package:audiory_v0/feat-manage-profile/screens/wallet/transaction_history.dart';
import 'package:audiory_v0/feat-manage-profile/widgets/transaction_card.dart';
import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/models/enums/TransactionType.dart';
import 'package:audiory_v0/models/transaction/transaction_model.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/repositories/transaction_repository.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../theme/theme_constants.dart';

class WalletScreen extends StatefulHookWidget {
  final AuthUser currentUser;
  const WalletScreen({super.key, required this.currentUser});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final transactionsQuery = useQuery(['transactions'],
        () => TransactionRepository.fetchMyTransactions(pageSize: 300));
    final userByIdQuery =
        useQuery(['user'], () => AuthRepository().getMyUserById());

    validFormatDateForParsing(String? date) {
      //for sort by date
      DateTime? newtime = DateFormat("yyyy-MM-dd").parse(date as String);
      return newtime.toString();
    }

    countTotal(
        List<Transaction> transactionList, List<TransactionType> listType) {
      double total = 0;

      var filteredList = transactionList
          .where((element) =>
              countDifference(
                  DateTime.now(),
                  DateTime.parse(
                      element.createdDate ?? DateTime.now().toString())) <=
              30)
          .toList()
          .where((element) => listType.contains(
              TransactionType.values.byName(element.transactionType ?? '')))
          .toList();
      for (var element in filteredList) {
        if (TransactionType.values.byName(element.transactionType ?? '') ==
            TransactionType.GIFT_SENT) {
          total = total + element.totalPrice;
        } else {
          total = total + element.totalPriceAfterCommission;
        }
      }

      return total;
    }

    //spending statistics
    Widget spendingStats(double total, String subContent, bool isUpward) {
      return SizedBox(
          width: size.width / 2.8,
          height: size.height * 0.07,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isUpward
                      ? Flexible(
                          child: Icon(
                          Icons.arrow_upward_sharp,
                          color: appColors.primaryDark,
                          size: 18,
                        ))
                      : Flexible(
                          child: Icon(
                          Icons.arrow_downward_sharp,
                          color: appColors.inkBase,
                          size: 18,
                        )),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 3.0,
                      ),
                      child: Text(
                        formatNumberWithSeperator(total),
                        style: textTheme.headlineMedium?.copyWith(
                            color: isUpward
                                ? appColors.primaryDark
                                : appColors.inkBase),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                subContent,
                textAlign: TextAlign.center,
                style:
                    textTheme.titleSmall?.copyWith(color: appColors.inkLight),
              ),
            ],
          ));
    }

    //transaction list
    return Scaffold(
      backgroundColor: appColors.inkDark,
      appBar: CustomAppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: appColors.skyLightest,
          ),
          onPressed: () {
            if (mounted) {
              context.pop();
            }
          },
        ),
        bgColor: appColors.inkDark,
        elevation: 0,
        title: Text(
          'Ví',
          style:
              textTheme.headlineMedium?.copyWith(color: appColors.skyLightest),
        ),
      ),
      body: Column(children: [
        Flexible(
          child: RefreshIndicator(
            onRefresh: () async {
              transactionsQuery.refetch();
            },
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.28),
                  height: size.height * 0.6,
                  decoration: BoxDecoration(
                      color: appColors.skyLightest,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.01),
                  height: size.height * 0.5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: Column(
                              children: [
                                Text(
                                  'Tổng xu',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: appColors.primaryLightest),
                                ),
                                Text(
                                  formatNumberWithSeperator(userByIdQuery
                                              .data?.wallets!.isNotEmpty ??
                                          false
                                      ? userByIdQuery.data?.wallets![0].balance
                                      : 0),
                                  style: textTheme.headlineLarge?.copyWith(
                                      color: appColors.primaryLightest,
                                      fontSize: 35),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      AppIconButton(
                        onPressed: () {
                          //get all coin packs and get all payment methods
                          //then create a purchase
                          context.pushNamed('newPurchase');
                        },
                        icon: Icon(
                          Icons.login_rounded,
                          color: appColors.primaryLightest,
                        ),
                        iconPosition: 'start',
                        title: 'Nạp/ Rút',
                        textStyle: textTheme.bodyMedium
                            ?.copyWith(color: appColors.inkBase)
                            .copyWith(color: appColors.primaryLightest),
                        bgColor: appColors.inkBase,
                      ),
                      //stats container
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 36, vertical: 40),
                        height: size.height * 0.1,
                        decoration: BoxDecoration(
                            color: appColors.primaryLightest,
                            boxShadow: [
                              BoxShadow(
                                color: appColors.inkBase.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 15,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(17))),
                        child: Skeletonizer(
                          enabled: transactionsQuery.isFetching,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                spendingStats(
                                    countTotal(transactionsQuery.data ?? [],
                                        [TransactionType.PURCHASE]),
                                    'Đã nạp trong 30 ngày',
                                    true),
                                SizedBox(
                                  width: 2,
                                  child: VerticalDivider(
                                    thickness: 1,
                                    color: appColors.skyBase,
                                    indent: size.height * 0.025,
                                    endIndent: size.height * 0.025,
                                  ),
                                ),
                                spendingStats(
                                    countTotal(transactionsQuery.data ?? [], [
                                      TransactionType.GIFT_SENT,
                                      TransactionType.CHAPTER_BOUGHT
                                    ]),
                                    'Đã sử dụng',
                                    false)
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.35),
                  child: SizedBox(
                    height: size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //history of transactions
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'Giao dịch gần đây',
                                        style: textTheme.headlineSmall
                                            ?.copyWith(
                                                color: appColors.inkDarkest),
                                      ),
                                    ),
                                    Flexible(
                                      child: GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            isDismissible: true,
                                            useSafeArea: true,
                                            useRootNavigator: true,
                                            builder: (context) {
                                              return const TransactionHistory();
                                            },
                                          );
                                        },
                                        child: Text(
                                          'Xem thêm',
                                          style: textTheme.bodyMedium?.copyWith(
                                            color: appColors.primaryDark,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 100),
                                height: size.height * 0.44,
                                child: Skeletonizer(
                                  enabled: transactionsQuery.isFetching,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0),
                                    child: ListView(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      children: List.generate(
                                          min(
                                              transactionsQuery.data?.length ??
                                                  0,
                                              20), (index) {
                                        transactionsQuery.data?.sort((a, b) {
                                          //sorting in ascending order
                                          return DateTime.parse(
                                                      validFormatDateForParsing(
                                                          a.createdDate))
                                                  .isBefore(DateTime.parse(
                                                      validFormatDateForParsing(
                                                          b.createdDate)))
                                              ? 1
                                              : -1;
                                        });
                                        return TransactionCard(
                                          transaction: transactionsQuery
                                              .data?[index] as Transaction,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
