import 'dart:math';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/cards/app_avatar_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScrollList extends StatelessWidget {
  final List<Profile>? profileList;
  final int? length;

  const ProfileScrollList(
      {super.key, required this.profileList, this.length = 5});
  @override
  Widget build(BuildContext context) {
    final list = profileList ?? [];
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    Widget followingCard(Profile? profile) {
      return GestureDetector(
        onTap: () {
          context.push('/accountProfile/${profile?.id}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppAvatarImage(
              size: 85,
              url: profile?.avatarUrl,
            ),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              width: 120,
              child: Center(
                child: Text(
                  '${profile?.fullName}',
                  style: textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow
                      .ellipsis, //wrap with container to enalble ...
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list
              .take(min(list.length ?? 0, 10))
              .map((profile) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: followingCard(profile),
                  ))
              .toList(),
        ));
  }
}
