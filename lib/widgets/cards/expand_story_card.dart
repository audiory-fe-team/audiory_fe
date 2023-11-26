import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExpandedStoryCard extends StatelessWidget {
  final String id;
  final String? coverUrl;
  final String title;

  const ExpandedStoryCard(
      {super.key, this.title = '', this.coverUrl, required this.id});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 3;

    return GestureDetector(
      onTap: () {
        context.push("/story/$id");
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Skeleton.shade(
                child: AspectRatio(
                    aspectRatio: 0.707,
                    child: AppImage(
                      url: coverUrl,
                      fit: BoxFit.fill,
                      width: width,
                    )),
              )),
          const SizedBox(height: 6),
          Text(title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
