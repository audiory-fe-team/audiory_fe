import 'package:audiory_v0/feat-manage-profile/models/PaymentMethod.dart';
import 'package:audiory_v0/feat-manage-profile/widgets/payment_method_card.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PaymentMethodModal extends StatefulHookWidget {
  final List<PaymentMethod?> list;
  final Function selectCallback;
  const PaymentMethodModal(
      {super.key, required this.list, required this.selectCallback});

  @override
  State<PaymentMethodModal> createState() => _PaymentMethodModalState();
}

class _PaymentMethodModalState extends State<PaymentMethodModal> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final paymentsList = widget.list;
    final selectedPurchaseMethod = useState<PaymentMethod?>(widget.list[0]);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        // mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Chọn nguồn nạp tiền',
            style: textTheme.headlineMedium,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: (paymentsList ?? []).asMap().entries.map((e) {
                  PaymentMethod method = e.value ?? PaymentMethod();

                  return GestureDetector(
                      onTap: () {
                        selectedPurchaseMethod.value = method;
                      },
                      child: PaymentMethodCard(
                          isSelected: selectedPurchaseMethod.value == method,
                          method: method));
                }).toList()),
          ),
          SizedBox(
            width: double.infinity,
            child: AppIconButton(
              onPressed: () {
                widget.selectCallback(selectedPurchaseMethod.value?.id ?? '');
              },
              title: 'Nạp tiền',
            ),
          )
        ],
      ),
    );
  }
}
