import 'package:audiory_v0/feat-write/screens/layout/compose_screen.dart';
import 'package:audiory_v0/widgets/buttons/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/theme_constants.dart';

class WriterScreen extends StatefulWidget {
  const WriterScreen({super.key});

  @override
  State<WriterScreen> createState() => _WriterScreenState();
}

class _WriterScreenState extends State<WriterScreen> {
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
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
    );
  }
}
