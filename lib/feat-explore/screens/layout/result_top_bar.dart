import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResultTopBar extends HookWidget implements PreferredSizeWidget {
  final String keyword;
  const ResultTopBar({super.key, required this.keyword});

  @override
  Size get preferredSize => Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textController = useTextEditingController(text: keyword);

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
                  controller: textController,
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
                InkWell(
                  onTap: () {
                    print("setting");
                  },
                  child: SvgPicture.asset(
                    'assets/icons/sliders.svg',
                    width: 16,
                    height: 16,
                    color: appColors.inkLighter,
                  ),
                )
              ],
            )));
  }
}
