import 'package:audiory_v0/feat-manage-profile/models/CoinPack.dart';
import 'package:audiory_v0/feat-manage-profile/models/PaymentMethod.dart';
import 'package:audiory_v0/feat-manage-profile/widgets/coin_pack_card.dart';
import 'package:audiory_v0/feat-manage-profile/widgets/vert_coin_pack_card.dart';
import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/coin_pack_repository.dart';
import 'package:audiory_v0/repositories/payment_method_repository.dart';
import 'package:audiory_v0/repositories/purchase_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';

class NewPurchaseScreen extends StatefulHookWidget {
  final AuthUser? currentUser;
  const NewPurchaseScreen({super.key, this.currentUser});

  @override
  State<NewPurchaseScreen> createState() => _NewPurchaseScreenState();
}

class _NewPurchaseScreenState extends State<NewPurchaseScreen> {
  String selectedCoinPackId = '';
  int selectedPaymentMethodId = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    //get all coin packs
    final coinStoreQuery =
        useQuery(['coinStore'], () => CoinPackRepository().fetchMyCoinStore());

    //get all payment methods
    final paymenthMethodsQuery = useQuery(['paymenthMethods'],
        () => PaymentMethodRepository().fetchAllPaymentMethods());

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

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Nạp thêm xu',
          style: textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            const SizedBox(
              height: 16,
            ),
            Text(
              'Phương thức thanh toán',
              style: textTheme.headlineMedium,
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  color: appColors.skyLightest,
                  borderRadius: BorderRadius.circular(4),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: appColors.skyDark.withOpacity(0.5),
                  //     spreadRadius: 2,
                  //     blurRadius: 7,
                  //     offset: const Offset(0, 3), // changes position of shadow
                  //   ),
                  // ],
                  border: Border.all(color: appColors.skyBase, width: 1)),
              width: size.width - 32,
              child: DropdownButton(
                alignment: Alignment.bottomCenter,
                value: selectedPaymentMethodId,
                underline: const SizedBox(height: 0),
                isExpanded: true,
                items: [...paymenthMethodsQuery.data ?? []]
                    .asMap()
                    .entries
                    .map((e) {
                  PaymentMethod paymentMethod = e.value;
                  return DropdownMenuItem(
                    value: paymentMethod.id,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Flexible(child: Text('${paymentMethod.name}')),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethodId = value ?? 1;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [...coinStoreQuery.data ?? []].asMap().entries.map((e) {
                CoinPack coinPack = e.value;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: CoinPackCard(
                    coinPack: coinPack,
                    onSelected: (id) {
                      // handleCreatePurchase();
                      setState(() {
                        selectedCoinPackId = id;
                      });
                    },
                    isSelected:
                        coinPack.id == selectedCoinPackId ? true : false,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: size.width - 32,
              child: AppIconButton(
                title: 'Thanh toán',
                onPressed: () {},
              ),
            )
          ])),
    );
  }
}
