import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

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
      this.fit = BoxFit.fill,
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
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: url!,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
