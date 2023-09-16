import 'dart:convert';

import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/state/state_manager.dart';
import 'package:audiory_v0/widgets/buttons/icon_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';
import '../../services/auth_services.dart';
import '../../theme/theme_constants.dart';
import '../../widgets/custom_app_bar.dart';

class ProfileScreenTest extends StatefulWidget {
  const ProfileScreenTest({super.key});

  @override
  State<ProfileScreenTest> createState() => ProfileScreenTestState();
}

class ProfileScreenTestState extends State<ProfileScreenTest> {
  final User? authUser = AuthService().currentUser;
  final storage = const FlutterSecureStorage();
  UserServer? currentUser;

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<UserServer?> getUserDetails() async {
    String? value = await storage.read(key: 'currentUser');
    currentUser =
        value != null ? UserServer.fromJson(jsonDecode(value)['data']) : null;

    if (kDebugMode) {
      print('currentuser ${currentUser?.email}');
    }
    return currentUser;
  }

  Widget _userInfo(UserServer? authUser) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(authUser?.email ?? 'Bạn cần đăng nhập '),
          authUser == null ? _signInButton() : _signOutButton()
        ],
      ),
    );
  }

  void _displaySnackBar(String? content) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: appColors.primaryBase,
      duration: const Duration(seconds: 3),
      content: Text(content as String),
      action: SnackBarAction(
        textColor: appColors.skyBase,
        label: 'Undo',
        onPressed: () {},
      ),
    ));
  }

  Future<void> signOut() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    final bool res = await AuthService().singOut();

    setState(() {
      currentUser = null;
    });

// ignore: use_build_context_synchronously
    context.pop();
    _displaySnackBar('Đăng xuất thành công');
  }

  Widget _signOutButton() {
    return SizedBox(
      width: double.infinity,
      child: AppIconButton(
          title: 'Đăng xuất',
          onPressed: () async {
            signOut();
          }),
    );
  }

  Widget _signInButton() {
    return SizedBox(
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

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: 60,
          title: Text(
            'Hồ sơ',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: appColors.inkBase),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings_outlined,
                  size: 25,
                ))
          ],
        ),
        body: FutureBuilder<UserServer?>(
          future: getUserDetails(), // async work
          builder: (BuildContext context, AsyncSnapshot<UserServer?> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return _userInfo(snapshot.data);
                }
            }
          },
        ),
      ),
    );
  }
}
