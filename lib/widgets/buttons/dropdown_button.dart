import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../theme/theme_constants.dart';

class AppDropdownButton extends StatelessWidget {
  final String? label;
  final bool? isRequired;
  final double? sizeBoxHeight;
  final List<DropdownMenuItem<Object>> itemsList;
  final List list;
  final initValue;
  final String name;
  const AppDropdownButton(
      {super.key,
      required this.itemsList,
      required this.name,
      this.label,
      required this.list,
      this.initValue,
      this.isRequired = false,
      this.sizeBoxHeight = 8});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    Widget requiredAsterisk() {
      return Flexible(
        child: Text(
          ' *',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.red),
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                label as String,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            isRequired == true
                ? requiredAsterisk()
                : const SizedBox(
                    height: 0,
                  )
          ],
        ),
        SizedBox(
          height: sizeBoxHeight ?? 8,
        ),
        FormBuilderDropdown(
          name: name,
          items: itemsList,
          initialValue: initValue ?? list[0],
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: appColors.skyBase,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(80)),
            ),

            border: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: appColors.primaryBase,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(80)),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: appColors.primaryBase,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(80))),
            filled: true,

            fillColor: Colors.transparent,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
            // labelText: "Email",
            focusColor: Colors.black12,
          ),
        ),
      ],
    );
  }
}
