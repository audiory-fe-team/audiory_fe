import 'package:audiory_v0/models/enums/TransactionType.dart';
import 'package:audiory_v0/models/transaction/transaction_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_date.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatefulWidget {
  final Transaction transaction;
  const TransactionCard({super.key, required this.transaction});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final containerSize = MediaQuery.of(context).size.width - 32;
    TransactionType transactionType = TransactionType.values.byName(
        widget.transaction.transactionType?.toUpperCase() ?? 'PURCHASE');
    Transaction transaction = widget.transaction;

    Map<String, dynamic> getStatus(context) {
      final AppColors appColors = Theme.of(context).extension<AppColors>()!;

      Map<String, dynamic> map = {
        'status': 'Đang xử lý',
        'color': appColors.inkLighter,
      };
      if (transaction.transactionStatus == 'FAILED') {
        map.update('status', (value) => 'Thất bại');
        map.update('color', (value) => appColors.secondaryBase);
      } else if (transaction.transactionStatus == 'FAILED') {
        map.update('status', (value) => 'Thành công');
        map.update('color', (value) => appColors.primaryBase);
      }
      return map;
    }

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: true,
            useSafeArea: true,
            builder: (context) {
              return Scaffold(
                appBar: CustomAppBar(
                  title: const Text('Chi tiết giao dịch'),
                ),
                body: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      margin: const EdgeInsetsDirectional.all(16),
                      padding: const EdgeInsetsDirectional.all(16),
                      height: size.height / 3,
                      decoration: BoxDecoration(
                          color: appColors.primaryLightest.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: containerSize * 0.15,
                                child: Container(
                                  width: containerSize * 0.15,
                                  height: containerSize * 0.15,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: appColors.skyBase),
                                      borderRadius: BorderRadius.circular(35),
                                      color: transactionType.displayBgColor
                                          .withOpacity(0.2)),
                                  child: Transform.rotate(
                                    angle: 0,
                                    child: Icon(
                                      transactionType.displayIcon,
                                      color: transactionType.displayIconColor,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: containerSize * 0.65,
                                  height: 60,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          transactionType.displayText,
                                          style: textTheme.titleMedium,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 2.0),
                                                child: Text(
                                                  '${transactionType.displayTrend} ${widget.transaction.totalPrice}',
                                                  style: textTheme.titleLarge
                                                      ?.copyWith(
                                                          color: appColors
                                                              .inkDarkest),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Image.asset(
                                                  transactionType.isCoin
                                                      ? 'assets/images/coin.png'
                                                      : 'assets/images/diamond.png',
                                                  width: 18),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Text(
                                'Trạng thái',
                                style: textTheme.titleMedium,
                              )),
                              Flexible(
                                  child: Text(
                                '${getStatus(context)['status']}',
                                style: textTheme.titleMedium?.copyWith(
                                    color: getStatus(context)['color']),
                              ))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Text(
                                'Thời gian',
                                style: textTheme.titleMedium,
                              )),
                              Flexible(
                                child: Text(
                                  appFormatDateWithHHmm(
                                      widget.transaction.createdDate),
                                  style: textTheme.bodySmall
                                      ?.copyWith(color: appColors.inkLight),
                                ),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Text(
                                'Loại giao dịch',
                                style: textTheme.titleMedium,
                              )),
                              Flexible(
                                child: Text(
                                  transactionType.displayText,
                                  style: textTheme.bodySmall
                                      ?.copyWith(color: appColors.inkLight),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
                ),
              );
            });
      },
      child: Container(
        width: containerSize,
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: appColors.skyBase,
          ),
        )),
        height: 80,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: containerSize * 0.15,
                child: Container(
                  width: containerSize * 0.14,
                  height: containerSize * 0.14,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: appColors.skyBase, width: 0.8),
                      borderRadius: BorderRadius.circular(35),
                      color: transactionType.displayBgColor.withOpacity(0.2)),
                  child: Transform.rotate(
                    angle: 0,
                    child: Icon(
                      transactionType.displayIcon,
                      color: transactionType.displayIconColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: containerSize * 0.55,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          transactionType.displayText,
                          style: textTheme.titleMedium,
                        ),
                        Text(
                          appFormatDateWithHHmm(widget.transaction.createdDate),
                          style: textTheme.bodySmall?.copyWith(
                              color: appColors.inkLight, fontSize: 12),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                width: containerSize * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '',
                      style: textTheme.titleLarge,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: Text(
                              '${transactionType.displayTrend} ${widget.transaction.totalPrice}',
                              style: textTheme.titleLarge
                                  ?.copyWith(color: appColors.inkDarkest),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Image.asset(
                              transactionType.isCoin
                                  ? 'assets/images/coin.png'
                                  : 'assets/images/diamond.png',
                              width: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
