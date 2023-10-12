import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String? defaultUrl;

  const AppImage(
      {super.key,
      this.url,
      this.width,
      this.height,
      this.fit,
      this.defaultUrl});

  @override
  Widget build(BuildContext context) {
    if (url == null || url == '') {
      return Image.asset(
        defaultUrl ?? 'assets/images/fallback_story_cover.png',
        width: width,
        height: height,
        fit: fit,
      );
    }
    return CachedNetworkImage(
        placeholder: (context, url) => Skeletonizer(
            enabled: true,
            child: Skeleton.replace(
                width: width, height: height, child: SizedBox())),
        width: width,
        height: height,
        fit: fit,
        imageUrl: url!);
  }
}
