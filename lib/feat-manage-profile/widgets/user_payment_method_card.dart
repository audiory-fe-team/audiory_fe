import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/models/user-payment-method/user_payment_method.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/buttons/tap_effect_wrapper.dart';
import 'package:flutter/material.dart';

class UserPaymentMethodCard extends StatefulWidget {
  final UserPaymentMethod? paymentMethod;
  final bool selected;
  final dynamic handleSelect;

  const UserPaymentMethodCard(
      {super.key,
      this.paymentMethod,
      this.selected = false,
      this.handleSelect});

  @override
  State<UserPaymentMethodCard> createState() => _UserPaymentMethodCardState();
}

class _UserPaymentMethodCardState extends State<UserPaymentMethodCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final UserPaymentMethod paymentMethod =
        widget.paymentMethod ?? const UserPaymentMethod(id: '');
    final String paymentImg = paymentMethod.paymentMethodId == 4 ? ZALO : MOMO;
    final bool isSelected = widget.selected;

    return TapEffectWrapper(
      onTap: widget.handleSelect,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
              color: isSelected ? appColors.skyLightest : Colors.transparent,
              border: isSelected
                  ? Border.all(color: appColors.primaryBase, width: 2)
                  : null,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 6,
                child: Row(
                  children: [
                    Flexible(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: AppImage(
                        url: paymentImg,
                        width: 40,
                      ),
                    )),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            paymentMethod.account ?? 'so dien thoai',
                            style: textTheme.titleMedium,
                          ),
                          Text(
                            paymentMethod.accountName ?? 'ten tai khoan',
                            style: textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              isSelected
                  ? Flexible(
                      child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: appColors.primaryBase, width: 6),
                            color: appColors.skyLightest,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ))
                  : const SizedBox(
                      height: 0,
                    ),
            ],
          )),
    );
  }
}
