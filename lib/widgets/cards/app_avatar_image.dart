import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppAvatarImage extends StatelessWidget {
  final String? url;
  final double? size;
  final bool? isOnline;
  const AppAvatarImage(
      {super.key, this.url, this.size = 65, this.isOnline = false});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    Widget newMessageBadge(Color color, double? size,
        {bool? isOnline = false}) {
      return Container(
        width: size ?? 20,
        height: size ?? 20,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
                color: isOnline == true ? appColors.skyLightest : color,
                width: 3)),
      );
    }

    return Stack(children: [
      Container(
        width: size ?? 65,
        height: size ?? 65,
        decoration: ShapeDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(url == null
                ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE5fPhctwNLodS9VmAniEw_UiLWHgKs0fs1w&usqp=CAU'
                : url == ''
                    ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE5fPhctwNLodS9VmAniEw_UiLWHgKs0fs1w&usqp=CAU'
                    : url as String),
            fit: BoxFit.fill,
          ),
          shape: const CircleBorder(),
        ),
      ),
      isOnline == true
          ? Positioned(
              bottom: 0,
              right: 0,
              child: newMessageBadge(
                  const Color.fromARGB(255, 57, 242, 153), 20,
                  isOnline: true),
            )
          : const SizedBox(
              height: 0,
            ),
    ]);
  }
}
