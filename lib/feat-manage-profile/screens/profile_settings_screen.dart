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
            Container(
              height: 50,
              // decoration: BoxDecoration(color: appColors.secondaryLighter),
              child: FormBuilderSwitch(
                inactiveThumbColor: appColors.inkLight,
                inactiveTrackColor: appColors.skyLighter,
                decoration: const InputDecoration(border: InputBorder.none),
                initialValue: isDarkMode,
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
            ),
            const Divider(
              thickness: 1,
            )
          ],
        );
      }

      Widget item(String title, String routerName, {bool? isPrivacy = false}) {
        return GestureDetector(
          onTap: () {
            routerName == ''
                ? null
                : isPrivacy == true
                    ? context.pushNamed(routerName,
                        extra: {'userId': widget.currentUser?.id})
                    : context.pushNamed(routerName, extra: {
                        'currentUser': widget.currentUser,
                        'userProfile': widget.userProfile
                      });
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Container(
                      // decoration: BoxDecoration(color: appColors.primaryBase),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9.0),
                        child: Text(
                          title,
                          style: textTheme.bodyMedium
                              ?.copyWith(color: appColors.inkDark),
                        ),
                      ),
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
            ],
          ),
        );
      }

      return Column(
        children: [
          item('Hồ sơ', 'editProfile'),
          const Divider(
            thickness: 1,
          ),
          sliderItem(),
          sliderItem(isDarkMode: true),
          item('Cài đặt tài khoản', 'editAccount'),
          const Divider(
            thickness: 1,
          ),
          // item('Bảo mật và an toàn', 'editProfile'),
          // const Divider(
          //   thickness: 1,
          // ),
          item('Ví của tôi', 'wallet'),

          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            width: double.infinity,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'BẢO MẬT VÀ AN TOÀN',
                style: textTheme.headlineMedium
                    ?.copyWith(color: appColors.inkLight),
              ),
            ]),
          ),
          item('Danh sách ngừng tương tác', 'muteAccounts', isPrivacy: true),
          const Divider(
            thickness: 1,
          ),
          item('Các tài khoản bị chặn', 'blockAccounts', isPrivacy: true),
          const Divider(
            thickness: 1,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            width: double.infinity,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'BÁO CÁO VÀ HỖ TRỢ',
                style: textTheme.headlineMedium
                    ?.copyWith(color: appColors.inkLight),
              ),
            ]),
          ),
          item('Xem các báo cáo', 'reports', isPrivacy: true),
          const Divider(
            thickness: 1,
          ),
          item('Báo cáo sự cố', 'reports', isPrivacy: true),
          const Divider(
            thickness: 1,
          ),
          item('Về Audiory', ''),
          // item('Hỗ trợ và tư vấn', ''),
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
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: listOfSettings()),
                ),
                Container(
                  width: size.width - 32,
                  margin: const EdgeInsets.only(bottom: 16),
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
