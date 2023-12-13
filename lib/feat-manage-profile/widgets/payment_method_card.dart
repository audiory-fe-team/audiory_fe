import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/feat-manage-profile/models/PaymentMethod.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:flutter/material.dart';

class PaymentMethodCard extends StatefulWidget {
  final PaymentMethod method;
  final bool isSelected;

  const PaymentMethodCard(
      {super.key, required this.method, required this.isSelected});

  @override
  State<PaymentMethodCard> createState() => _PaymentMethodCardState();
}

class _PaymentMethodCardState extends State<PaymentMethodCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            border: widget.isSelected == true
                ? Border.all(color: appColors.primaryBase, width: 2)
                : Border.all(color: Colors.transparent, width: 2),
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
                      url: widget.method.id == 1 ? MOMO : ZALO,
                      width: 40,
                    ),
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Text(
                      widget.method.name ?? 'ten tai khoan',
                      style: textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
            widget.isSelected == true
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
        ));
  }
}
