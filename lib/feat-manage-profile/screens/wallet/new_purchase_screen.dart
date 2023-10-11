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
  final UserServer? currentUser;
  const NewPurchaseScreen({super.key, this.currentUser});

  @override
  State<NewPurchaseScreen> createState() => _NewPurchaseScreenState();
}

class _NewPurchaseScreenState extends State<NewPurchaseScreen> {
  String selectedCoinPackId = '';
  String selectedPaymentMethodId = '1';
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
    final coinPacksQuery =
        useQuery(['coinPacks'], () => CoinPackRepository().fetchAllCoinPacks());

    //get all payment methods
    final paymenthMethodsQuery = useQuery(['paymenthMethods'],
        () => PaymentMethodRepository().fetchAllPaymentMethods());

    handleCreatePurchase() {
      if (kDebugMode) {
        print('COINPACK ID $selectedCoinPackId');
        print('METHOD ID $selectedPaymentMethodId');
      }
      if (selectedCoinPackId == '' || selectedPaymentMethodId == '') {
        AppSnackBar.buildTopSnackBar(
            context, 'Hãy chọn', null, SnackBarType.error);
      } else {
        Map<String, dynamic> body = {};
        body['coin_pack_id'] = selectedCoinPackId;
        body['payment_method_id'] = int.parse(selectedPaymentMethodId);

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            //
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Text(
            //     'Gói xu',
            //     style: textTheme.headlineMedium,
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            Center(child: CoinPackCard()),

            // SizedBox(
            //   height: size.height / 5,
            //   child: ListView.builder(
            //     itemCount: coinPacksQuery.data?.length ?? 0,
            //     prototypeItem: const ListTile(
            //       title: Text('first'),
            //     ),
            //     itemBuilder: (context, index) {
            //       return GestureDetector(
            //         onTap: () {
            //           setState(() {
            //             selectedCoinPackId = coinPacksQuery.data?[index].id ?? '';
            //           });
            //         },
            //         child: Container(
            //             margin:
            //                 const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //             decoration: BoxDecoration(
            //                 color: appColors.skyLightest,
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 20,
            //                       spreadRadius: 3,
            //                       color: appColors.inkLight.withOpacity(0.2))
            //                 ],
            //                 borderRadius: BorderRadius.circular(8)),
            //             child: Center(
            //                 child: Text(
            //               coinPacksQuery.data?[index].name ?? 'blank',
            //               style: textTheme.titleLarge
            //                   ?.copyWith(color: appColors.primaryBase),
            //             ))),
            //       );
            //     },
            //   ),
            // ),
            //payment methods
            // Text(
            //   'Phương thức thanh toán',
            //   style: textTheme.headlineMedium,
            // ),
            // SizedBox(
            //   height: size.height / 3,
            //   child: ListView.builder(
            //     itemCount: paymenthMethodsQuery.data?.length ?? 0,
            //     prototypeItem: const ListTile(
            //       title: Text('first'),
            //     ),
            //     itemBuilder: (context, index) {
            //       return GestureDetector(
            //         onTap: () {
            //           setState(() {
            //             selectedPaymentMethodId =
            //                 '${paymenthMethodsQuery.data?[index].id}'; //id was a num
            //           });
            //         },
            //         child: Container(
            //             height: 200,
            //             margin: const EdgeInsets.symmetric(
            //                 horizontal: 16, vertical: 8),
            //             decoration: BoxDecoration(
            //                 color: appColors.skyLightest,
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 20,
            //                       spreadRadius: 3,
            //                       color: appColors.inkLight.withOpacity(0.2))
            //                 ],
            //                 borderRadius: BorderRadius.circular(8)),
            //             child: Center(
            //                 child: Column(
            //               children: [
            //                 Text(
            //                   paymenthMethodsQuery.data?[index].name ?? 'blank',
            //                   style: textTheme.titleLarge
            //                       ?.copyWith(color: appColors.primaryBase),
            //                 ),
            //                 Text(
            //                   '${paymenthMethodsQuery.data?[index].id}' ??
            //                       'blank',
            //                   style: textTheme.bodySmall
            //                       ?.copyWith(color: appColors.primaryBase),
            //                 ),
            //               ],
            //             ))),
            //       );
            //     },
            //   ),
            // ),

            // AppIconButton(
            //   onPressed: () {
            //     handleCreatePurchase();
            //   },
            //   title: 'Nạp xu',
            // )
          ])),
    );
  }
}
