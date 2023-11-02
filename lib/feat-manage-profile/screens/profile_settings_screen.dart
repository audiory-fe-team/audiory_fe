import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/theme/theme_manager.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/cards/app_avatar_image.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/Profile.dart';
import '../../theme/theme_constants.dart';

class ProfileSettingsScreen extends ConsumerStatefulWidget {
  final AuthUser? currentUser;
  final Profile? userProfile;
  const ProfileSettingsScreen({super.key, this.currentUser, this.userProfile});

  @override
  ConsumerState<ProfileSettingsScreen> createState() =>
      _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends ConsumerState<ProfileSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final notifier = ref.watch(themeNotifierProvider);

    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    Widget listOfSettings() {
      Widget sliderItem({bool isDarkMode = false}) {
        return Column(
          children: [
            FormBuilderSwitch(
              decoration: const InputDecoration(border: InputBorder.none),
              initialValue: false,
              activeColor: appColors.primaryBase,
              name: 'isNotified',
              onChanged: (value) {
                isDarkMode
                    ? notifier.setTheme(
                        value == true ? ThemeMode.dark : ThemeMode.light)
                    : null;
              },
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isDarkMode ? 'Chế độ ban đêm' : 'Thông báo',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: appColors.inkBase),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            )
          ],
        );
      }

      Widget item(
        String title,
        String routerName,
      ) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    title,
                    style: textTheme.bodyMedium
                        ?.copyWith(color: appColors.inkDark),
                  ),
                ),
                Flexible(
                  child: IconButton(
                    onPressed: () {
                      context.pushNamed(routerName, extra: {
                        'currentUser': widget.currentUser,
                        'userProfile': widget.userProfile
                      });
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: appColors.inkLighter,
                      size: 14,
                    ),
                  ),
                )
              ],
            ),
            const Divider(
              thickness: 1,
            )
          ],
        );
      }

      return Column(
        children: [
          item('Hồ sơ', 'editProfile'),
          sliderItem(),
          sliderItem(isDarkMode: true),
          item('Cài đặt tài khoản', 'editAccount'),
          item('Bảo mật và an toàn', 'editProfile'),
          item('Ví của tôi', 'wallet'),
          item('Về Audiory', 'editProfile'),
          item('Hỗ trợ và tư vấn', 'editProfile'),
        ],
      );
    }

    Widget userInfo() {
      return Column(
        children: [
          AppAvatarImage(
            url: widget.currentUser?.avatarUrl,
            size: size.width / 3.5,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              widget.currentUser?.fullName ?? '_',
              style: textTheme.headlineSmall,
            ),
          ),
          Text(
            widget.currentUser?.username ?? '_',
            style: textTheme.titleMedium?.copyWith(color: appColors.skyDark),
          ),
        ],
      );
    }

    Future<void> signOut() async {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });
      await AuthRepository().singOut();

      // ignore: use_build_context_synchronously
      context.go('/login');
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Cài đặt',
          style: textTheme.headlineMedium,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context).push('/profileSettings/messages',
                    extra: {'userId': widget.currentUser?.id});
              },
              child: const Icon(Icons.messenger_outline),
            ),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: userInfo(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: listOfSettings()),
                ),
                Container(
                  width: size.width - 32,
                  child: AppIconButton(
                      title: 'Đăng xuất',
                      onPressed: () {
                        signOut();
                      }),
                )
              ]),
        ),
      ),
    );
  }
}
