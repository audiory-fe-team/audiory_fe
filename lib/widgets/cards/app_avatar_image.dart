import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppAvatarImage extends StatelessWidget {
  final String? url;
  final bool? showBackgroundUrl;
  final String? backgroundUrl;
  final double? size;
  final bool? isOnline;
  final bool? hasLevel;
  final int? levelId;
  final bool? hasAuthorLevel;
  final int? authorLevelId;

  const AppAvatarImage(
      {super.key,
      this.url,
      this.showBackgroundUrl = false,
      this.backgroundUrl = FALLBACK_BACKGROUND_URL,
      this.size = 65,
      this.isOnline = false,
      this.hasLevel = false,
      this.levelId = 1,
      this.hasAuthorLevel = false,
      this.authorLevelId = 1});

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

    Widget levelFrame() {
      return Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: levelId == 1
            ? const EdgeInsets.only(top: 10)
            : const EdgeInsets.all(0),
        child: Image.asset(
          levelId == 1
              ? 'assets/images/level_bronze.png'
              : levelId == 2
                  ? 'assets/images/level_silver.png'
                  : 'assets/images/level_gold.png',
        ),
      );
    }

    Widget authorLevelFrame() {
      return Container(
        height: 200,
        alignment: Alignment.center,
        margin: authorLevelId == 1
            ? const EdgeInsets.only(bottom: 20)
            : const EdgeInsets.only(bottom: 20),
        child: Image.asset(
            authorLevelId == 1
                ? 'assets/images/author_level_1.png'
                : authorLevelId == 2
                    ? 'assets/images/author_level_2.png'
                    : 'assets/images/author_level_3.png',
            width: authorLevelId == 1 ? (size ?? 65) * 2 : (size ?? 65) * 3),
      );
    }

    return hasLevel == true || hasAuthorLevel == true
        ? Container(
            height: (size ?? 65) + 100,
            width: double.infinity,
            child: Stack(alignment: Alignment.center, children: [
              Container(
                width: size ?? 65,
                height: size ?? 65,
                decoration: ShapeDecoration(
                  color: appColors.inkBase,
                  // image: DecorationImage(
                  //   image:
                  //   fit: BoxFit.fill,
                  // ),
                  shape: const CircleBorder(),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: AppImage(
                      url: url,
                      fit: BoxFit.fill,
                      width: size,
                      height: size,
                    )),
              ),
              hasLevel == true || hasAuthorLevel == true
                  ? Positioned(
                      width: hasLevel == true
                          ? (size ?? 65) + 50
                          : (size ?? 65) + 90,
                      child:
                          hasLevel == true ? levelFrame() : authorLevelFrame())
                  : const SizedBox(
                      height: 0,
                    ),
              // hasLevel == true || hasAuthorLevel == true
              //     ? Positioned(
              //         bottom: 0,
              //         width: 200,
              //         child: Text(
              //           'chien than tap su',
              //           textAlign: TextAlign.center,
              //         ))
              //     : const SizedBox(
              //         height: 0,
              //       ),
            ]),
          )
        : Stack(children: [
            Container(
              width: size ?? 65,
              height: size ?? 65,
              decoration: ShapeDecoration(
                // image: DecorationImage(
                //   image: CachedNetworkImageProvider(
                //       url == null
                //           ? DEFAULT_AVATAR
                //           : url == ''
                //               ? DEFAULT_AVATAR
                //               : url ?? '',
                //       errorListener: (_) {}),
                //   fit: BoxFit.fill,
                // ),
                shape: const CircleBorder(),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: AppImage(
                    url: url,
                    fit: BoxFit.fill,
                    width: size,
                    height: size,
                  )),
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
