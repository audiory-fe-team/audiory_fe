import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserProfileTopBar extends StatefulWidget implements PreferredSizeWidget {
  final AuthUser? currentUser;
  final Profile? userProfile;
  UserProfileTopBar({super.key, this.currentUser, this.userProfile});

  @override
  State<UserProfileTopBar> createState() => _UserProfileTopBarState();
  Size get preferredSize => const Size.fromHeight(58);
}

class _UserProfileTopBarState extends State<UserProfileTopBar> {
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appColors.inkLight,
            width: 0.5,
            style: BorderStyle.solid,
          ),
        ),
      ),
      width: size.width,
      child: Stack(children: [
        SizedBox(
          width: size.width,
          child: Center(
            child: Text(
              'Hồ sơ',
              style: textTheme.headlineSmall,
            ),
          ),
        ),
        Positioned(
            height: 60,
            right: 0,
            child: IconButton(
              alignment: Alignment.center,
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                context.pushNamed('profileSettings', extra: {
                  'currentUser': widget.currentUser,
                  'userProfile': widget.userProfile
                });
              },
            ))
      ]),
    );
  }
}
