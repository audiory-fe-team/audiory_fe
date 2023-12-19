import 'package:audiory_v0/widgets/report_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../repositories/auth_repository.dart';
import '../../../theme/theme_constants.dart';

class DashboardCustomAppbar extends StatefulHookWidget
    implements PreferredSizeWidget {
  const DashboardCustomAppbar({super.key});

  @override
  State<DashboardCustomAppbar> createState() => _DashboardCustomAppbarState();
  Size get preferredSize => const Size.fromHeight(58);
}

class _DashboardCustomAppbarState extends State<DashboardCustomAppbar> {
  final User? user = AuthRepository().currentUser;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final userQuery = useQuery([
      'userById',
    ], () => AuthRepository().getMyUserById());
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
                'Thống kê',
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
                  })),
          Positioned(
              height: 60,
              right: 0,
              child: IconButton(
                  alignment: Alignment.centerLeft,
                  icon: const Icon(Icons.flag_outlined),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          String userId = userQuery.data?.id ?? '';
                          return ReportDialog(
                              reportType: 'REVENUE_COMPLAINT',
                              reportId: userId);
                        });
                  }))
        ]),
      ),
    );
  }
}
