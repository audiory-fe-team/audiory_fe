import 'dart:convert';

import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/state/state_manager.dart';
import 'package:audiory_v0/widgets/buttons/icon_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import '../../models/User.dart';
import '../../services/auth_services.dart';
import '../../theme/theme_constants.dart';
import '../../widgets/custom_app_bar.dart';

class ProfileScreenTest extends ConsumerStatefulWidget {
  const ProfileScreenTest({super.key});

  @override
  ConsumerState<ProfileScreenTest> createState() => ProfileScreenTestState();
}

class ProfileScreenTestState extends ConsumerState<ProfileScreenTest> {
  final User? authUser = AuthService().currentUser;
  final FlutterSecureStorage storage = FlutterSecureStorage();
  // AuthUser? authUser;
  // Future<void> getAuthUser() async {
  //   final user = await storage.read(key: 'authUser') as String;
  //   authUser = await jsonDecode(user);
  //   print('auth');
  //   print(authUser);
  // }

  Widget _userEmail(User authUser) {
    return Text(authUser.email == null ? 'Null' : authUser.email as String);
  }

  // Widget _userId() {
  //   return Text(authUser?.id ?? 'User id');
  // }

  Future<void> signOut() async {
    await AuthService().singOut();
    context.go('/login');
  }

  Widget _signOutButton() {
    return Container(
      width: double.infinity,
      child: AppIconButton(
          title: 'Đăng xuất',
          onPressed: () async {
            signOut();
          }),
    );
  }

  Widget _signInButton() {
    return Container(
      width: double.infinity,
      child: AppIconButton(
          title: 'Đăng nhập',
          onPressed: () async {
            context.go('/login');
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    // final AsyncValue<UserServer> authUser = ref.watch(authUserProvider);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: 60,
          title: Text(
            'Cá nhân',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: appColors.inkBase),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings_outlined,
                  size: 25,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              _userEmail(authUser!),
              // _userId(),
              // authUser == null ? _signInButton() : _signOutButton()
            ],
          ),
        ),
      ),
    );
  }
}
