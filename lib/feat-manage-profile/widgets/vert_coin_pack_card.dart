import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';

class VerticalCoinPackCard extends StatelessWidget {
  const VerticalCoinPackCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    return CouponCard(
      height: 300,
      curvePosition: 180,
      curveRadius: 30,
      borderRadius: 10,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            appColors.primaryBase,
            appColors.primaryBase.withAlpha(100),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      firstChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'CHIRISTMAS SALES',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '16%',
            style: TextStyle(
              color: Colors.white,
              fontSize: 56,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'OFF',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      secondChild: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 42),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 80),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.white,
            ),
          ),
          onPressed: () {},
          child: Text(
            'Mua ngay',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: appColors.primaryBase,
            ),
          ),
        ),
      ),
    );
  }
}
