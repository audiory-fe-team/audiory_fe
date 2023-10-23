import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class DetailStoryTopBar extends StatelessWidget implements PreferredSizeWidget {
  final Story? story;

  const DetailStoryTopBar({super.key, required this.story});

  @override
  Size get preferredSize => const Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return SafeArea(
        child: Container(
            height: 58,
            width: double.infinity,
            // padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (GoRouter.of(context).canPop()) {
                      GoRouter.of(context).pop();
                    }
                  },
                  icon: Icon(Icons.arrow_back,
                      size: 24, color: appColors.inkBase),
                ),
                const SizedBox(width: 4),
                Expanded(
                    child: Text(story?.title ?? '',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineSmall)),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert_rounded,
                      size: 24, color: appColors.inkBase),
                )
              ],
            )));
  }
}
