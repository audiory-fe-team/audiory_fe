import 'package:audiory_v0/feat-manage-profile/models/CoinPack.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/purchase_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CoinPackCard extends StatefulWidget {
  final CoinPack coinPack;
  final Function onSelected;
  final bool? isSelected;
  const CoinPackCard(
      {Key? key,
      required this.coinPack,
      required this.onSelected,
      this.isSelected = false})
      : super(key: key);

  @override
  State<CoinPackCard> createState() => _CoinPackCardState();
}

class _CoinPackCardState extends State<CoinPackCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    double promotionPercentage = (1 -
            (widget.coinPack.priceAfterPromotion! /
                (widget.coinPack.price ?? 1))) *
        100;

    print(widget.coinPack.priceAfterPromotion);
    print(widget.coinPack.price ?? '');
    print(
        (widget.coinPack.priceAfterPromotion! / (widget.coinPack.price ?? 1)));
    moveToMomo(url) async {
      print('PAYURL ${url}');
      print('MOVE TO MOMO');
      // check if spotify is installed
      if (await canLaunchUrl(Uri.parse(url))) {
        // launch the url which will open spotify
        launchUrl(Uri.parse(url));
      } else {
        print('cant launch');
      }
    }

    handleCreatePurchase(
        {String coinPackId = '', int paymentMethodId = 1}) async {
      // if (kDebugMode) {
      //   print('COINPACK ID $selectedCoinPackId');
      //   print('METHOD ID $selectedPaymentMethodId');
      // }
      // if (selectedCoinPackId == '' || selectedPaymentMethodId == '') {
      //   AppSnackBar.buildTopSnackBar(
      //       context, 'Hãy chọn', null, SnackBarType.error);
      // } else {
      print('coin ${coinPackId}');
      Map<String, dynamic> body = {};
      body['coin_pack_id'] = coinPackId;
      body['payment_method_id'] = 1;

      try {
        final newPurchase = await PurchaseRepository().createPurchase(body);
        print('new purchase $newPurchase');
        // AppSnackBar.buildTopSnackBar(
        //     context, 'Đang chuyển sang momo', null, SnackBarType.info);

        moveToMomo(newPurchase);
      } catch (e) {
        AppSnackBar.buildTopSnackBar(
            context, 'Tạo thất bại', null, SnackBarType.info);
      }
      // }
    }

    return GestureDetector(
        onTap: () {
          print('alo');
          handleCreatePurchase(coinPackId: widget.coinPack.id ?? '');
          widget.onSelected(widget.coinPack.id);
        },
        child: Container(
          width: size.width,
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: widget.isSelected == true
              ? BoxDecoration(
                  color: appColors.skyLightest,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: appColors.skyDark.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  border: Border.all(color: appColors.inkBase, width: 2))
              : BoxDecoration(
                  color: appColors.skyLightest,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: appColors.skyDark.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            AppImage(
              url: widget.coinPack.imageUrl,
              width: size.width / 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              width: size.width / 3.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.coinPack.coinAmount} xu',
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.start,
                  ),
                  // promotionPercentage != 0
                  //     ? Text(
                  //         // 'Giảm ${promotionPercentage.toStringAsFixed(0)}%',
                  //         '${NumberFormat('###,000').format(widget.coinPack.price)}đ',
                  //         textAlign: TextAlign.center,
                  //         style: textTheme.titleSmall?.copyWith(
                  //           color: appColors.inkBase,
                  //           decoration: TextDecoration.lineThrough,
                  //         ),
                  //       )
                  //     : SizedBox(
                  //         height: 0,
                  //       ),
                ],
              ),
            ),
            Container(
              width: size.width / 3,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                  color: appColors.skyLight,
                  borderRadius: BorderRadius.circular(40)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${NumberFormat('###,000').format(widget.coinPack.priceAfterPromotion)}đ',
                    textAlign: TextAlign.center,
                    style: textTheme.titleLarge
                        ?.copyWith(color: appColors.secondaryBase),
                  ),
                  promotionPercentage != 0
                      ? Text(
                          '${NumberFormat('###,000').format(widget.coinPack.price)}đ',
                          textAlign: TextAlign.center,
                          style: textTheme.titleSmall?.copyWith(
                              color: appColors.inkBase,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 10),
                        )
                      : SizedBox(
                          height: 0,
                        ),
                ],
              ),
            )
          ]),
        ));
  }
}
