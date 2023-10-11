import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/purchase_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CoinPackCard extends StatelessWidget {
  const CoinPackCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    Color primaryColor = appColors.primaryLightest;
    Color secondaryColor = appColors.primaryBase;
    moveToMomo(url) async {
      // check if spotify is installed
      if (await canLaunchUrl(Uri.parse(url as String))) {
        // launch the url which will open spotify
        launchUrl(Uri.parse(url as String));
      }
    }

    handleCreatePurchase() async {
      // if (kDebugMode) {
      //   print('COINPACK ID $selectedCoinPackId');
      //   print('METHOD ID $selectedPaymentMethodId');
      // }
      // if (selectedCoinPackId == '' || selectedPaymentMethodId == '') {
      //   AppSnackBar.buildTopSnackBar(
      //       context, 'Hãy chọn', null, SnackBarType.error);
      // } else {
      Map<String, dynamic> body = {};
      body['coin_pack_id'] = '8bfd2f9c-4e29-11ee-977e-e0d4e8a18075';
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
        handleCreatePurchase();
      },
      child: CouponCard(
        width: size.width - 32,
        height: 150,
        backgroundColor: primaryColor,
        curveAxis: Axis.vertical,
        firstChild: Container(
          decoration: BoxDecoration(
            color: secondaryColor,
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '-23%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Text(
                      //   'OFF',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.white54, height: 0),
              Expanded(
                child: Center(
                  child: Text(
                    'Giá hot',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        secondChild: Container(
          width: size.width - 32,
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Gói xu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '100',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                '5 ngày với mức giá này',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
