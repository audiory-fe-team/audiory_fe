import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../repositories/auth_repository.dart';
import '../../../theme/theme_constants.dart';

class RevenueCustomAppbar extends StatefulWidget
    implements PreferredSizeWidget {
  const RevenueCustomAppbar({super.key});

  @override
  State<RevenueCustomAppbar> createState() => _RevenueCustomAppbarState();
  Size get preferredSize => const Size.fromHeight(58);
}

class _RevenueCustomAppbarState extends State<RevenueCustomAppbar> {
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
                'Thu nhập tác phẩm',
                style: textTheme.headlineSmall,
              ),
            ),
          ),
          Positioned(
              height: 60,
              left: 0,
              child: IconButton(
                  alignment: Alignment.centerLeft,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    context.pop();
                  }))
        ]),
      ),
    );
  }
}
