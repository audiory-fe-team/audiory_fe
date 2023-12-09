import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';

class ReadingTopBar extends HookWidget implements PreferredSizeWidget {
  final String storyId;
  const ReadingTopBar({
    super.key,
    required this.storyId,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final storyQuery = useQuery(
      ['story', storyId],
      () => StoryRepostitory().fetchStoryById(storyId),
    );
    return SafeArea(
        child: Material(
            color: Colors.transparent,
            child: Container(
                height: 58,
                // padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(255, 172, 136, 28),
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (GoRouter.of(context).canPop()) {
                            GoRouter.of(context).pop();
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                          child: Text(storyQuery.data?.title ?? '',
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  Theme.of(context).textTheme.headlineSmall)),
                      const SizedBox(width: 4),
                    ]))));
  }
}
