import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/auth_services.dart';
import '../../../theme/theme_constants.dart';
import '../../../widgets/custom_app_bar.dart';

class WriterCustomAppBar extends StatefulWidget {
  const WriterCustomAppBar({super.key});

  @override
  State<WriterCustomAppBar> createState() => _WriterCustomAppBarState();
}

class _WriterCustomAppBarState extends State<WriterCustomAppBar> {
  final User? user = AuthService().currentUser;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    return CustomAppBar(
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
    );
  }
}
