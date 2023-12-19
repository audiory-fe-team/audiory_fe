import 'dart:async';

import 'package:audiory_v0/feat-manage-profile/models/CoinPack.dart';
import 'package:audiory_v0/feat-manage-profile/widgets/coin_pack_card.dart';
import 'package:audiory_v0/feat-manage-profile/widgets/payment_method_modal.dart';
import 'package:audiory_v0/feat-manage-profile/widgets/user_payment_method_card.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/user-payment-method/user_payment_method.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/repositories/coin_pack_repository.dart';
import 'package:audiory_v0/repositories/payment_method_repository.dart';
import 'package:audiory_v0/repositories/transaction_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:audiory_v0/widgets/app_alert_dialog.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/buttons/tap_effect_wrapper.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/custom_dialog.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class WithdrawScreen extends StatefulHookWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  final _createFormKey = GlobalKey<FormBuilderState>();
  TextEditingController numController = TextEditingController();

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

    final userPaymentMethodQuery = useQuery(['userPaymentQuery'],
        () => PaymentMethodRepository().fetchMyPaymentMethod(userId: 'me'));

    final userQuery = useQuery([
      'userById',
    ], () => AuthRepository().getMyUserById());

    final selectedPaymentId = useState('');

    final totalVND =
        int.tryParse(_formKey.currentState?.fields['num']?.value ?? '0') ?? 0;

    useEffect(() {
      selectedPaymentId.value = userPaymentMethodQuery.data?[0].id ?? '';
    }, [userPaymentMethodQuery.data]);

    Stream<String> getTransactionStream(id) {
      var status = 'PROCESSING';

      return Stream.periodic(Duration(seconds: 1), (int count) {
        TransactionRepository.fetchMyTransactions()
            .then((value) => {status = value?[0].transactionStatus ?? ''});
        return status;
      });
    }

    showConfirmChapterDeleteDialog(
        BuildContext context, price, accountId) async {
      return showDialog<void>(
        context: context, // User must tap button to close the dialog
        builder: (BuildContext context) {
          return AppAlertDialog(
            title: 'Xác nhận rút',
            content: 'Bạn có chắc chắn muốn rút về ví $totalVND,000 đ ?',
            actionText: 'Xác nhận',
            actionCallBack: () async {
              // Perform the action
              _formKey.currentState?.save();
              if (_formKey.currentState?.validate() ?? false) {
                // If the form is valid, display a Snackbar.
                Map<String, dynamic> body = {
                  'total_price': int.tryParse(
                          _formKey.currentState?.fields['num']?.value) ??
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
                  context.pop();
                  userQuery.refetch();

                  // ignore: use_build_context_synchronously
                  showDialog(
                      context: context,
                      builder: (context) {
                        return StreamBuilder<String>(
                          stream: getTransactionStream(res?.id),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.data == 'SUCCEEDED'
                                  ? CustomDialog(
                                      content: 'Rút thành công về ví',
                                      alertType: 'success',
                                      actionCallBack: () {
                                        userQuery.refetch();
                                      },
                                    )
                                  : CustomDialog(
                                      content: 'Giao dịch đang xử lý',
                                      alertType: 'processing',
                                      actionCallBack: () {
                                        userQuery.refetch();
                                      },
                                    );
                            } else if (snapshot.hasError) {
                              return CustomDialog(
                                content: 'Giao dịch đang xử lý',
                                alertType: 'processing',
                                actionCallBack: () {
                                  userQuery.refetch();
                                },
                              );
                            } else {
                              // Handle loading or initial state
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        );
                      });

                  userQuery.refetch();
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  context.pop();

                  // ignore: use_build_context_synchronously
                  AppSnackBar.buildTopSnackBar(context,
                      'Rút về ví không thành công', null, SnackBarType.error);
                }
              }
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Rút',
          style: textTheme.headlineMedium,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          userPaymentMethodQuery.refetch();
          userQuery.refetch();
        },
        child: SizedBox(
            height: size.height * 0.9,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rút tiền từ',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: appColors.skyLightest,
                        border:
                            Border.all(color: appColors.primaryBase, width: 2),
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
                          Skeletonizer(
                            enabled: userQuery.isFetching,
                            child: Container(
                              width: size.width / 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                      flex: 2,
                                      child: Text(
                                        '${double.tryParse(userQuery.data?.wallets?[1].balance.toString() ?? '0')?.toStringAsFixed(1)}',
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FormBuilder(
                    key: _formKey,
                    onChanged: () {
                      setState(() {
                        _formKey.currentState?.save();
                      });
                    },
                    child: AppTextInputField(
                      onChangeCallback: (value) {},
                      autoFocus: true,
                      name: 'num',
                      validator: (value) {
                        // if (value?.isEmpty == true) {
                        //   return 'Bắt buộc điền';
                        // }
                        // if ((int.tryParse(value ?? '0') ?? 0).toDouble() >
                        //         (userQuery.data?.wallets?[1].balance ??
                        //             0) &&
                        //     value != '') {
                        //   return 'Nhiều hơn số lượng có thể rút';
                        // }
                        // if ((int.tryParse(value ?? '0') ?? 0).toDouble() <
                        //         50 &&
                        //     value != '') {
                        //   // Replace 10 with your min value
                        //   return 'Tối thiểu 50 kim cương';
                        // }
                      },
                      inputLable: Text(
                        'Số kim cương muốn rút',
                        style: textTheme.titleMedium
                            ?.copyWith(color: appColors.inkLighter),
                      ),
                      textInputType: TextInputType.number,
                      borderRadius: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Thành tiền',
                          style: textTheme.titleMedium
                              ?.copyWith(color: appColors.inkLighter),
                        ),
                      ),
                      // Flexible(
                      //   child: Text(
                      //     totalVND == ''
                      //         ? '0 đ'
                      //         : '${formatNumberWithSeperator(totalVND ?? '0')},000 đ',
                      //     style: textTheme.titleMedium
                      //         ?.copyWith(color: appColors.inkLighter),
                      //   ),
                      // ),

                      Flexible(
                        child: Text(
                          totalVND == 0
                              ? '0 đ'
                              : '${formatNumberWithSeperator(totalVND ?? 0)},000 đ',
                          style: textTheme.titleMedium
                              ?.copyWith(color: appColors.inkLighter),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Đến nguồn tiền',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Skeletonizer(
                    enabled: userPaymentMethodQuery.isFetching,
                    child: Column(
                      children: [...userPaymentMethodQuery.data ?? []]
                          .asMap()
                          .entries
                          .map((e) {
                        int index = e.key;
                        UserPaymentMethod userPaymentMethod = e.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: UserPaymentMethodCard(
                            paymentMethod: userPaymentMethod,
                            selected:
                                userPaymentMethod.id == selectedPaymentId.value
                                    ? true
                                    : false,
                            handleSelect: () {
                              selectedPaymentId.value =
                                  userPaymentMethod.id ?? '';
                              // _formKey.currentState?.save();
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  TapEffectWrapper(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          useSafeArea: true,
                          builder: (context) {
                            return Scaffold(
                              appBar: CustomAppBar(
                                  title: Text(
                                'Tạo mới nguồn nhận tiền',
                                style: textTheme.headlineSmall,
                              )),
                              body: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 24),
                                child: Column(
                                  children: [
                                    FormBuilder(
                                      key: _createFormKey,
                                      onChanged: () {
                                        setState(() {
                                          _createFormKey.currentState?.save();
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          AppTextInputField(
                                            name: 'account',
                                            hintText: '012 456 7891',
                                            label: 'Số điện thoại',
                                            textInputType: TextInputType.number,
                                            validator:
                                                FormBuilderValidators.compose([
                                              FormBuilderValidators.match(
                                                  r'^(\+\d{1,2}\s?)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$',
                                                  errorText:
                                                      'Nhập số điện thoại sai định dạng'),
                                              FormBuilderValidators.required(
                                                  errorText: 'Bắt buộc nhập')
                                            ]),
                                          ),
                                          AppTextInputField(
                                            name: 'name',
                                            hintText: 'Dong My',
                                            label: 'Tên tài khoản',
                                            validator:
                                                FormBuilderValidators.compose([
                                              FormBuilderValidators.required(
                                                  errorText: 'Bắt buộc nhập')
                                            ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: AppIconButton(
                                        onPressed: () async {
                                          if (_createFormKey
                                                  .currentState?.isValid ==
                                              true) {
                                            _createFormKey.currentState?.save();
                                            String userId =
                                                userQuery.data?.id ?? "";
                                            Map<String, dynamic> body = {
                                              'account': _createFormKey
                                                  .currentState
                                                  ?.fields['account'],
                                              'account_name': _createFormKey
                                                  .currentState?.fields['name'],
                                              'payment_method_id': 4,
                                            };
                                            dynamic response =
                                                await PaymentMethodRepository()
                                                    .createUserPaymentMethod(
                                                        body, userId);
                                            if (response != null) {
                                              // ignore: use_build_context_synchronously
                                              // AppSnackBar.buildTopSnackBar(
                                              //     context,
                                              //     'Tạo thành công',
                                              //     null,
                                              //     SnackBarType.success);
                                              // ignore: use_build_context_synchronously
                                              context.pop();
                                              userPaymentMethodQuery.refetch();
                                            } else {
                                              // ignore: use_build_context_synchronously
                                              // AppSnackBar.buildTopSnackBar(
                                              //     context,
                                              //     'Tạo không thành công',
                                              //     null,
                                              //     SnackBarType.success);
                                              // ignore: use_build_context_synchronously
                                              context.pop();
                                            }
                                          } else {
                                            AppSnackBar.buildTopSnackBar(
                                                context,
                                                'Nhập để đi tiếp',
                                                null,
                                                SnackBarType.error);
                                          }
                                        },
                                        title: 'Tạo nguồn tiền',
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: appColors.skyLightest,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          Text('Thêm nguồn tiền'),
                        ],
                      )),
                    ),
                  ),
                ],
              ),
            )),
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        height: 40,
        width: double.infinity,
        child: AppIconButton(
          onPressed: () async {
            _formKey.currentState?.save();
            if (_formKey.currentState?.validate() ?? false) {
              dynamic totalDia = double.tryParse(
                  userQuery.data?.wallets?[1].balance.toString() ?? '0');
              double dia = double.tryParse(
                      _formKey.currentState?.fields['num']?.value) ??
                  0;

              if (dia >= 50 && dia < totalDia) {
                await showConfirmChapterDeleteDialog(
                    context, dia, selectedPaymentId.value);
              } else {
                FocusManager.instance.primaryFocus?.unfocus();
                AppSnackBar.buildTopSnackBar(
                    context, 'Nhập số kim cương', null, SnackBarType.info);
              }
            } else {
              AppSnackBar.buildTopSnackBar(
                  context, 'Nhập số kim cương', null, SnackBarType.info);
            }
          },
          title: 'Rút tiền',
        ),
      ),
    );
  }
}
