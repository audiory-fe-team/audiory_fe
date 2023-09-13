import 'dart:async';

import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class SearchTopBar extends HookWidget implements PreferredSizeWidget {
  final Function(String) onSearchValueChange;
  const SearchTopBar({super.key, required this.onSearchValueChange});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final controller = useTextEditingController();
    Timer? debounce;

    return SafeArea(
        child: Container(
            width: double.infinity,
            height: 65,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    if (debounce?.isActive ?? false) debounce?.cancel();
                    debounce = Timer(const Duration(milliseconds: 500), () {
                      onSearchValueChange(value);
                    });
                  },
                  onSubmitted: (value) {
                    GoRouter.of(context).goNamed("explore_result",
                        queryParameters: {'keyword': value});
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
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    fillColor: appColors.skyLightest,
                    filled: true,
                  ),
                )),
                const SizedBox(width: 12),
                GestureDetector(
                  child: Text(
                    'Hủy',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: appColors.inkLighter),
                  ),
                )
              ],
            )));
  }
}
