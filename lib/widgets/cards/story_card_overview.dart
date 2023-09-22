import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StoryCardOverView extends StatelessWidget {
  final String id;
  final String? coverUrl;
  final String title;

  const StoryCardOverView(
      {super.key, this.title = '', this.coverUrl = '', required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push("/story/$id");
      },
      child: SizedBox(
        width: 95,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skeleton.replace(
                width: 95,
                height: 135,
                child: Container(
                  width: 95,
                  height: 135,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(coverUrl ?? ''),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                )),
            const SizedBox(height: 8),
            Text(this.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
