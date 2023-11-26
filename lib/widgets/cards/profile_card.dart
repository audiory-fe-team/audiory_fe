import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileCard extends StatelessWidget {
  final Profile user;

  const ProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        context.push(
          '/accountProfile/${user.id}',
        );
      },
      child: Container(
        width: double.infinity,
        height: 54,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(user.avatarUrl ?? ''),
                  fit: BoxFit.fill,
                ),
                shape: const CircleBorder(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName ?? 'Ẩn danh',
                        style: textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        '@${user.username}',
                        style: textTheme.titleSmall?.copyWith(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            color: appColors.inkLight),
                        overflow: TextOverflow.ellipsis,
                      ),
                      // child: Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     SvgPicture.asset(
                      //       'assets/icons/eye.svg',
                      //       width: 14,
                      //       color: appColors.primaryBase,
                      //     ),
                      //     const SizedBox(width: 4),
                      //     Text(
                      //       '@${user.username}',
                      //       style: textTheme.titleSmall!.copyWith(
                      //           fontStyle: FontStyle.italic,
                      //           fontWeight: FontWeight.w600,
                      //           color: appColors.primaryBase),
                      //       overflow: TextOverflow.ellipsis,
                      //     )
                      //   ],
                      // )
                    ],
                  )),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
