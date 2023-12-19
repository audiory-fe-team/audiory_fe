import 'package:audiory_v0/feat-write/screens/author_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../repositories/auth_repository.dart';
import '../../../theme/theme_constants.dart';

class WriterCustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const WriterCustomAppBar({super.key});

  @override
  State<WriterCustomAppBar> createState() => _WriterCustomAppBarState();
  Size get preferredSize => const Size.fromHeight(58);
}

class _WriterCustomAppBarState extends State<WriterCustomAppBar> {
  final User? user = AuthRepository().currentUser;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Container(
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
                'Tác phẩm',
                style: textTheme.headlineSmall,
              ),
            ),
          ),
          Positioned(
              height: 60,
              right: 0,
              child: IconButton(
                alignment: Alignment.center,
                icon: const Icon(Icons.bar_chart_rounded),
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      useRootNavigator: true,
                      barrierColor: Colors.transparent,
                      useSafeArea: true,
                      context: context,
                      enableDrag: false,
                      builder: (context) {
                        return const AuthorDashboard();
                      });
                },
              ))
        ]),
      ),
    );
  }
}
