import 'package:audiory_v0/feat-write/screens/layout/compose_screen.dart';
import 'package:audiory_v0/feat-write/screens/layout/writer_app_bar.dart';
import 'package:audiory_v0/widgets/buttons/icon_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/auth_services.dart';
import '../../theme/theme_constants.dart';
import '../../widgets/custom_app_bar.dart';

class WriterScreen extends StatefulWidget {
  const WriterScreen({super.key});

  @override
  State<WriterScreen> createState() => _WriterScreenState();
}

class _WriterScreenState extends State<WriterScreen> {
  final User? authUser = Auth().currentUser;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return authUser != null
        ? Scaffold(
            appBar: CustomAppBar(
              height: 60,
              title: Text(
                'Tác phẩm',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: appColors.inkBase),
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.dashboard_outlined,
                      size: 30,
                    ))
              ],
            ),
            floatingActionButton: AppIconButton(
              title: 'Viết truyện',
              textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: appColors.skyLightest, fontWeight: FontWeight.w700),
              onPressed: () {
                context.go('/composeStory');
              },
              icon: Icon(Icons.edit_outlined),
              iconPosition: 'start',
            ),
          )
        : Scaffold(
            appBar: CustomAppBar(
              height: 60,
              title: Text(
                'Tác phẩm',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: appColors.inkBase),
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.dashboard_outlined,
                      size: 30,
                    ))
              ],
            ),
            body: Center(
              child: Text('Đăng nhập để viết'),
            ),
          );
  }
}
