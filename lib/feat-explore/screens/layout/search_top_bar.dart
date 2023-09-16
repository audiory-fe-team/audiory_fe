import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchTopBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

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
