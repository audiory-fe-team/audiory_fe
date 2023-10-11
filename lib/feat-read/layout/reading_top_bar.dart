import 'package:audiory_v0/widgets/buttons/tap_effect_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ReadingTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String? storyName;
  final String? storyId;
  const ReadingTopBar({super.key, this.storyName = '', this.storyId = ''});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Material(
            elevation: 2,
            child: Container(
                height: 58,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                color: Colors.white,
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TapEffectWrapper(
                          onTap: () {
                            if (storyId != null) {
                              GoRouter.of(context).go('/story/${storyId}');
                            }
                          },
                          child: SvgPicture.asset('assets/icons/left-arrow.svg',
                              width: 20, height: 20)),
                      const SizedBox(width: 4),
                      Expanded(
                          child: Text(storyName ?? '',
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  Theme.of(context).textTheme.headlineSmall)),
                      const SizedBox(width: 4),
                      SvgPicture.asset('assets/icons/more-vertical.svg',
                          width: 20, height: 20),
                    ]))));
  }
}
