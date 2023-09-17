import 'dart:async';

import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchTopBar extends HookWidget implements PreferredSizeWidget {
  final Function(String) onSearchValueChange;
  final Function() onSubmit;
  final Function() onTap;
  final bool isTyping;
  final TextEditingController controller;
  const SearchTopBar(
      {super.key,
      required this.onSearchValueChange,
      required this.onSubmit,
      required this.isTyping,
      required this.onTap,
      required this.controller});

  @override
  Size get preferredSize => const Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    Timer? debounce;

    return SafeArea(
        child: Material(
            elevation: 2,
            child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: TextField(
                      onTap: () {
                        onTap();
                      },
                      controller: controller,
                      onChanged: (value) {
                        if (debounce?.isActive ?? false) debounce?.cancel();
                        debounce = Timer(const Duration(milliseconds: 200), () {
                          onSearchValueChange(value);
                        });
                      },
                      onSubmitted: (value) {
                        onSubmit();
                      },
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm truyện/tác giả',
                        hintStyle: TextStyle(color: appColors.inkLighter),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 0),
                        fillColor: appColors.skyLightest,
                        filled: true,
                      ),
                    )),
                    const SizedBox(width: 12),
                    IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () {
                          onSubmit();
                        },
                        icon: const Icon(
                          Icons.search_rounded,
                          size: 16,
                        ))
                  ],
                ))));
  }
}
