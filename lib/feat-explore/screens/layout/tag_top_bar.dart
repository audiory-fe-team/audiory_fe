import 'package:audiory_v0/widgets/buttons/tap_effect_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class TagTopBar extends HookWidget implements PreferredSizeWidget {
  final String tagName;
  const TagTopBar({super.key, required this.tagName});

  @override
  Size get preferredSize => const Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Material(
            elevation: 2,
            child: Container(
                height: 58,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TapEffectWrapper(
                        onTap: () {
                          if (GoRouter.of(context).canPop()) {
                            GoRouter.of(context).pop();
                          }
                        },
                        child: SvgPicture.asset('assets/icons/left-arrow.svg',
                            width: 20, height: 20)),
                    const SizedBox(width: 4),
                    Expanded(
                        child: Text('Truyen gắn thẻ $tagName',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headlineSmall))
                  ],
                ))));
  }
}
