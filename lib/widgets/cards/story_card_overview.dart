import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/widgets/app_image.dart';
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
        context.push("/story/$id");
      },
      child: SizedBox(
        width: 95,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skeleton.shade(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: AppImage(
                      url: coverUrl,
                      fit: BoxFit.cover,
                      width: 95,
                      height: 135,
                    ))),
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
