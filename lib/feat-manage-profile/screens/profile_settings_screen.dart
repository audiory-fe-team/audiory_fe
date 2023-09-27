import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

import '../../models/Profile.dart';
import '../../theme/theme_constants.dart';

class ProfileSettingsScreen extends StatefulWidget {
  final UserServer? currentUser;
  final Profile? userProfile;
  const ProfileSettingsScreen({super.key, this.currentUser, this.userProfile});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    Widget listOfSettings() {
      Widget sliderItem() {
        return Column(
          children: [
            FormBuilderSwitch(
              decoration: const InputDecoration(border: InputBorder.none),
              initialValue: false,
              activeColor: appColors.primaryBase,
              name: 'isNotified',
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thông báo',
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
          item('Cài đặt tài khoản', 'editAccount'),
          sliderItem(),
          item('Bảo mật và an toàn', 'editProfile'),
          item('Ví', 'wallet'),
          item('Về Audiory', 'editProfile'),
          item('Hỗ trợ và tư vấn', 'editProfile'),
        ],
      );
    }

    Widget userInfo() {
      return Column(
        children: [
          Material(
            child: InkWell(
              onTap: () async {
                context.push('/profile');
              },
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.network(
                    'https://img.freepik.com/premium-vector/people-saving-money_24908-51569.jpg?w=2000',
                    width: size.width / 3.5,
                    height: size.width / 3.5,
                  )),
            ),
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

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Cài đặt',
          style: textTheme.headlineMedium,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {},
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
              ]),
        ),
      ),
    );
  }
}
