import 'dart:async';

import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/feat-manage-profile/models/CoinPack.dart';
import 'package:audiory_v0/feat-manage-profile/models/PaymentMethod.dart';
import 'package:audiory_v0/feat-manage-profile/widgets/coin_pack_card.dart';
import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/coin_pack_repository.dart';
import 'package:audiory_v0/repositories/payment_method_repository.dart';
import 'package:audiory_v0/repositories/purchase_repository.dart';
import 'package:audiory_v0/repositories/transaction_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';

class NewPurchaseScreen extends StatefulHookWidget {
  final AuthUser? currentUser;
  const NewPurchaseScreen({super.key, this.currentUser});

  @override
  State<NewPurchaseScreen> createState() => _NewPurchaseScreenState();
}

class _NewPurchaseScreenState extends State<NewPurchaseScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  String selectedCoinPackId = '';
  int selectedPaymentMethodId = 1;
  late TabController tabController;
  int tabState = 0;
  @override
  void initState() {
    // TODO: implement initStateTônTôn
    super.initState();

    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    //get all coin packs
    final coinStoreQuery =
        useQuery(['coinStore'], () => CoinPackRepository().fetchMyCoinStore());

    final userPaymentMethodQuery = useQuery(
        ['userPaymentQuery'],
        () => PaymentMethodRepository()
            .fetchMyPaymentMethod(userId: widget.currentUser?.id));

    handleCreatePurchase() {
      if (selectedCoinPackId == '' || selectedPaymentMethodId == '') {
        AppSnackBar.buildTopSnackBar(
            context, 'Hãy chọn', null, SnackBarType.error);
      } else {
        Map<String, dynamic> body = {};
        body['coin_pack_id'] = selectedCoinPackId;
        body['payment_method_id'] = selectedPaymentMethodId;

        try {
          PurchaseRepository().createPurchase(body);
          AppSnackBar.buildTopSnackBar(
              context, 'Đang chuyển sang momo', null, SnackBarType.info);
        } catch (e) {
          AppSnackBar.buildTopSnackBar(
              context, 'Tạo thất bại', null, SnackBarType.info);
        }
      }
    }

    getStatus(id) async {
      print(id);
      var status = '';
      await TransactionRepository.fetchTransaction(id)
          .then((value) => {status = value?.transactionStatus ?? ''});

      return status;
    }

    getTransactionStatus(id) {
      print('helo');
      var status = 'FAILED';
      Timer.periodic(
        const Duration(seconds: 1),
        (timer) async => status = await getStatus(id),
      );

      return status;
    }

    Future<void> showConfirmChapterDeleteDialog(
        BuildContext context, price, accountId) async {
      final AppColors appColors = Theme.of(context).extension<AppColors>()!;

      final textTheme = Theme.of(context).textTheme;
      return showDialog<void>(
        context: context, // User must tap button to close the dialog
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Center(child: Text('Xác nhận rút?')),
            content: SizedBox(
              height: 100,
              child: Column(
                children: [
                  Text(
                    'Bạn chắc chắn muốn rút ${double.tryParse(price)?.toStringAsFixed(0)} kim cương. Bạn sẽ nhận về ví  ${price.toString()},000 đồng',
                    style: textTheme.titleMedium,
                    textAlign: TextAlign.justify,
                  ),
                  // Text(
                  //   'Bạn sẽ nhận về ví  ${price.toString()},000 đồng',
                  //   style: textTheme.titleMedium,
                  //   textAlign: TextAlign.justify,
                  // )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Hủy',
                  style: textTheme.titleMedium,
                ),
                onPressed: () {
                  context.pop(); // Dismiss the dialog
                },
              ),
              Container(
                width: 70,
                height: 30,
                child: AppIconButton(
                  bgColor: appColors.secondaryLight,
                  color: appColors.skyLight,
                  title: 'Có',
                  onPressed: () async {
                    // Perform the action
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a Snackbar.
                      Map<String, dynamic> body = {
                        'total_price': int.tryParse(
                                _formKey.currentState!.fields['num']?.value) ??
                            0,
                        'user_payment_method_id': accountId
                      };
                      try {
                        var res = await PaymentMethodRepository()
                            .withdraw(body)
                            .then((value) {
                          print(value);
                        });

                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (context) {
                              // String status = getTransactionStatus(res);
                              return AlertDialog(
                                title: Text(
                                  'Thông báo',
                                  style: textTheme.titleLarge,
                                  textAlign: TextAlign.justify,
                                ),
                                content: Container(
                                    height: size.height / 4,
                                    child: Text(
                                      'Giao dịch đang được xử lý, tiền sẽ được rút về nguồn tiền của bạn trong vòng 1 giờ.',
                                      style: textTheme.titleMedium,
                                      textAlign: TextAlign.justify,
                                    )),
                                actions: [
                                  AppIconButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    title: 'Tôi đã hiểu',
                                  )
                                ],
                              );
                            });

                        // AppSnackBar.buildTopSnackBar(context,
                        //     'Rút về ví thành công', null, SnackBarType.success);
                      } catch (e) {
                        print(e);
                        context.pop();

                        // ignore: use_build_context_synchronously
                        AppSnackBar.buildTopSnackBar(
                            context,
                            'Rút về ví không thành công',
                            null,
                            SnackBarType.error);
                      }
                    }
                  },
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Nạp / Rút',
          style: textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
              child: TabBar(
                onTap: (value) {
                  setState(() {
                    if (tabState != value) tabState = value;
                  });
                },
                controller: tabController,
                labelColor: appColors.primaryBase,
                unselectedLabelColor: appColors.inkLight,
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                indicatorColor: appColors.primaryBase,
                labelStyle: textTheme.titleLarge,
                tabs: const [
                  Tab(
                    text: 'Nạp xu',
                  ),
                  Tab(
                    text: 'Rút kim cương',
                  )
                ],
              ),
            ),
            Builder(builder: (context) {
              if (tabState == 0) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       color: appColors.skyLightest,
                      //       borderRadius: BorderRadius.circular(4),
                      //       // boxShadow: [
                      //       //   BoxShadow(
                      //       //     color: appColors.skyDark.withOpacity(0.5),
                      //       //     spreadRadius: 2,
                      //       //     blurRadius: 7,
                      //       //     offset: const Offset(0, 3), // changes position of shadow
                      //       //   ),
                      //       // ],
                      //       border: Border.all(color: appColors.skyBase, width: 1)),
                      //   width: size.width - 32,
                      //   child: DropdownButton(
                      //     alignment: Alignment.bottomCenter,
                      //     value: selectedPaymentMethodId,
                      //     underline: const SizedBox(height: 0),
                      //     isExpanded: true,
                      //     items: [...paymenthMethodsQuery.data ?? []]
                      //         .asMap()
                      //         .entries
                      //         .map((e) {
                      //       PaymentMethod paymentMethod = e.value;
                      //       return DropdownMenuItem(
                      //         value: paymentMethod.id,
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Row(
                      //             children: [
                      //               Flexible(child: Text('${paymentMethod.name}')),
                      //             ],
                      //           ),
                      //         ),
                      //       );
                      //     }).toList(),
                      //     onChanged: (value) {
                      //       setState(() {
                      //         selectedPaymentMethodId = value ?? 1;
                      //       });
                      //     },
                      //   ),
                      // ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [...coinStoreQuery.data ?? []]
                            .asMap()
                            .entries
                            .map((e) {
                          CoinPack coinPack = e.value;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            child: CoinPackCard(
                              coinPack: coinPack,
                              onSelected: (id) {
                                // handleCreatePurchase();
                                setState(() {
                                  selectedCoinPackId = id;
                                });
                              },
                              isSelected: coinPack.id == selectedCoinPackId
                                  ? true
                                  : false,
                            ),
                          );
                        }).toList(),
                      ),
                    ]);
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rút tiền từ',
                        style: textTheme.titleLarge,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: appColors.skyLightest,
                            border: Border.all(
                                color: appColors.primaryBase, width: 2),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  flex: 1,
                                  child: Text(
                                    'Ví kim cương',
                                    style: textTheme.titleMedium,
                                  )),
                              Container(
                                width: size.width / 3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                        flex: 2,
                                        child: Text(
                                          formatNumberWithSeperator(widget
                                                  .currentUser
                                                  ?.wallets?[1]
                                                  .balance ??
                                              0),
                                          style: textTheme.titleLarge,
                                        )),
                                    Flexible(
                                      flex: 3,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Image.asset(
                                            'assets/images/diamond.png',
                                            width: 24),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      FormBuilder(
                        key: _formKey,
                        child: AppTextInputField(
                          // textAlign: TextAlign.center,
                          // label: 'Nhập số kim cương muốn rút',
                          name: 'num',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Bắt buộc điền';
                            }
                            if (int.tryParse(value)! >
                                (widget.currentUser?.wallets?[1].balance ??
                                    0)) {
                              return 'Nhiều hơn số lượng có thể rút';
                            }
                            if (int.tryParse(value)! < 50) {
                              // Replace 10 with your min value
                              return 'Tối thiểu 50 kim cương';
                            }
                          },
                          inputLable: Text(
                            'Nhập số kim cương muốn rút',
                            style: textTheme.titleMedium
                                ?.copyWith(color: appColors.inkLighter),
                          ),
                          textInputType: TextInputType.number,
                          borderRadius: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Đến nguồn tiền',
                        style: textTheme.titleLarge,
                      ),
                      Container(
                        margin: const EdgeInsetsDirectional.only(top: 8),
                        height: 70,
                        child: ListView.builder(
                            itemCount: userPaymentMethodQuery.data?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: appColors.skyLightest,
                                      border: Border.all(
                                          color: appColors.primaryBase,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              userPaymentMethodQuery
                                                      .data?[index].account ??
                                                  'so dien thoai',
                                              style: textTheme.titleMedium,
                                            ),
                                            Text(
                                              userPaymentMethodQuery
                                                      .data?[index]
                                                      .accountName ??
                                                  'ten tai khoan',
                                              style: textTheme.titleMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                          child: ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: AppImage(
                                          url: MOMO,
                                          width: 40,
                                        ),
                                      ))
                                    ],
                                  ));
                            }),
                      ),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: AppIconButton(
                          onPressed: () async {
                            _formKey.currentState?.save();
                            if (_formKey.currentState?.validate() ?? false) {
                              dynamic totalDia =
                                  widget.currentUser?.wallets?[1].balance ?? 0;
                              double dia = double.tryParse(_formKey
                                      .currentState?.fields['num']?.value) ??
                                  0;

                              if (dia >= 50 && dia < totalDia) {
                                showConfirmChapterDeleteDialog(
                                    context,
                                    _formKey.currentState!.fields['num']?.value,
                                    userPaymentMethodQuery.data?[0].id);
                              }
                            }
                          },
                          title: 'Rút tiền',
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
