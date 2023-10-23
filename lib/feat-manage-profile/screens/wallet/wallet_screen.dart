import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/models/enums/TransactionType.dart';
import 'package:audiory_v0/models/transaction/transaction_model.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/repositories/transaction_repository.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../theme/theme_constants.dart';

class WalletScreen extends StatefulHookWidget {
  final UserServer currentUser;
  const WalletScreen({super.key, required this.currentUser});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  convertThousands(num) {
    if (num < 100) {
      return '${double.parse(num.toString()).toStringAsFixed(0)}';
    }
    var formatter = NumberFormat('#,##,000');
    return formatter.format(num);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final transactionsQuery = useQuery(
        ['transactions'], () => TransactionRepository.fetchMyTransactions());
    final userByIdQuery =
        useQuery(['user'], () => AuthRepository().getMyUserById());
    String formatDate(String? date) {
      DateTime dateTime = DateTime.parse(date as String);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    }

    validFormatDateForParsing(String? date) {
      DateTime? newtime = DateFormat("yyyy-MM-dd").parse(date as String);
      return newtime.toString();
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
                        '${convertThousands(total)}',
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
    Widget transactionCard(Transaction transaction) {
      final containerSize = size.width - 32;

      TransactionType transactionType = TransactionType.values
          .byName(transaction.transactionType?.toUpperCase() ?? 'PURCHASE');
      return Container(
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
                          formatDate(transaction.createdDate),
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
                      '${transactionType.displayTrend} ${transaction.totalPrice} xu',
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
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.04),
                child: SizedBox(
                  height: size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Tổng xu',
                          style: textTheme.bodyMedium
                              ?.copyWith(color: appColors.primaryLightest),
                        ),
                        Text(
                          '${convertThousands(userByIdQuery.data?.wallets?[0].balance ?? 0)}',
                          style: textTheme.headlineLarge?.copyWith(
                              color: appColors.primaryLightest, fontSize: 50),
                        ),
                        AppIconButton(
                          onPressed: () {
                            //get all coin packs and get all payment methods
                            //then create a purchase

                            context.pushNamed('newPurchase',
                                extra: {'currentUser': widget.currentUser});
                          },
                          icon: const Icon(Icons.add),
                          iconPosition: 'start',
                          title: 'Nạp thêm xu',
                          isOutlined: true,
                          color: appColors.primaryLightest,
                          bgColor: appColors.inkDark,
                        ),
                        //stats container
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 36, vertical: 32),
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
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                spendingStats(1000, 'Đã nạp trong tuần', true),
                                SizedBox(
                                  width: 2,
                                  child: VerticalDivider(
                                    thickness: 1,
                                    color: appColors.skyBase,
                                    indent: size.height * 0.025,
                                    endIndent: size.height * 0.025,
                                  ),
                                ),
                                spendingStats(100, 'Đã sử dụng', false)
                              ]),
                        ),
                        //history of transactions
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Lịch sử giao dịch',
                                      style: textTheme.headlineMedium?.copyWith(
                                          color: appColors.inkDarkest),
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
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16),
                                height: size.height * 0.41,
                                child: Skeletonizer(
                                  enabled: transactionsQuery.isFetching,
                                  child: ListView(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    children: List.generate(
                                        transactionsQuery.data?.length ?? 0,
                                        (index) {
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
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: transactionCard(transactionsQuery
                                            .data?[index] as Transaction),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              // Column(
                              //   children: List.generate(
                              //       4,
                              //       (index) => Padding(
                              //             padding: const EdgeInsets.symmetric(
                              //                 vertical: 8.0),
                              //             child: transactionCard(),
                              //           )).toList(),
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
