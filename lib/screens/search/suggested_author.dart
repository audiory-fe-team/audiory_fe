import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/app_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuggestedAuthor extends StatelessWidget {
  final String coverUrl;
  final String name;
  final int follower;

  const SuggestedAuthor(
      {required this.name, required this.follower, required this.coverUrl});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Container(
        width: 70,
        height: 124,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 70,
                    height: 70,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(this.coverUrl),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    )),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/user.svg',
                          width: 12,
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              "230,5 k",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(fontWeight: FontWeight.w400),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 21,
              child: AppOutlinedButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                style: ButtonStyle(
                    side: MaterialStatePropertyAll(
                        BorderSide(color: appColors.secondaryBase)),
                    alignment: Alignment.center),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/heart.svg',
                      width: 10,
                      height: 10,
                      color: appColors.secondaryBase,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Theo dõi',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: appColors.secondaryBase),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
