import 'package:audiory_v0/constants/fallback_image.dart';
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
      this.fit,
      this.defaultUrl});

  @override
  Widget build(BuildContext context) {
    print('url $url');
    if (url == null || url == '') {
      return Image.asset(
        'assets/images/fallback_story_cover.png',
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
