import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../theme/theme_constants.dart';

class WalletScreen extends StatefulWidget {
  final UserServer currentUser;
  const WalletScreen({super.key, required this.currentUser});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  convertThousands(double num) {
    var formatter = NumberFormat('#,##,000');
    return formatter.format(num);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

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
                    textTheme.titleMedium?.copyWith(color: appColors.inkLight),
              ),
            ],
          ));
    }

    //transaction list
    Widget transactionCard() {
      final containerSize = size.width - 32;

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
                      color: appColors.primaryLightest.withOpacity(0.5)),
                  child: Transform.rotate(
                    angle: 0,
                    child: Icon(
                      Icons.arrow_upward,
                      color: appColors.primaryDark,
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
                          'Nạp thành công vào ví',
                          style: textTheme.titleLarge,
                        ),
                        Text(
                          '28/9  11:40',
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '',
                      style: textTheme.titleLarge,
                    ),
                    Text(
                      '+ 1000 xu',
                      style: textTheme.headlineMedium
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
                          '${convertThousands(1699)}',
                          style: textTheme.headlineLarge?.copyWith(
                              color: appColors.primaryLightest, fontSize: 50),
                        ),
                        AppIconButton(
                          onPressed: () {},
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
                                height: size.height * 0.45,
                                child: ListView(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  children: List.generate(
                                      10,
                                      (index) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: transactionCard(),
                                          )).toList(),
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
