import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

import '../../models/AuthUser.dart';
import '../../theme/theme_constants.dart';

class EditAccountScreen extends StatefulWidget {
  final UserServer? currentUser;
  final Profile? userProfile;
  const EditAccountScreen({super.key, this.currentUser, this.userProfile});

  @override
  State<EditAccountScreen> createState() => EditAccountScreenState();
}

class EditAccountScreenState extends State<EditAccountScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    Widget userInfo() {
      Widget listOfSettings() {
        Widget item(String title, String routerName, String subContent) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: textTheme.bodyMedium
                                ?.copyWith(color: appColors.inkDark),
                          ),
                          Text(
                            subContent,
                            style: textTheme.titleMedium
                                ?.copyWith(color: appColors.skyDark),
                          )
                        ],
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
            ),
          );
        }

        return Column(
          children: [
            item('Tên đăng nhập', 'editEmail',
                widget.userProfile?.username ?? 'username'),
            item('Email', 'editEmail',
                widget.currentUser?.email ?? 'email@gmail.com'),
            item('Mật khẩu', 'editProfile', '*******'),
          ],
        );
      }

      //put a single child scroll view in center widget
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(
          children: [
            FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // <-- SEE HERE
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'TÀI KHOẢN',
                    style: textTheme.headlineSmall
                        ?.copyWith(color: appColors.primaryBase),
                  ),
                  listOfSettings(),
                  Text(
                    'ƯU TIÊN TRUYỆN',
                    style: textTheme.headlineSmall
                        ?.copyWith(color: appColors.primaryBase),
                  ),
                  FormBuilderSwitch(
                    decoration: const InputDecoration(border: InputBorder.none),
                    name: 'isMature',
                    initialValue: false,
                    activeColor: appColors.primaryBase,
                    title: Text(
                      'Cho phép hiện nội dung trưởng thành',
                      style: textTheme.bodyMedium,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
          title: Text(
        'Cài đặt tài khoản',
        style: textTheme.headlineMedium?.copyWith(color: appColors.inkBase),
      )),
      body: userInfo(),
    );
  }
}
