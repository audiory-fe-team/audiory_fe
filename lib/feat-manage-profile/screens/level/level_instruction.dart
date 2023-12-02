import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LevelInstruction extends StatefulWidget {
  const LevelInstruction({super.key});

  @override
  State<LevelInstruction> createState() => _LevelInstructionState();
}

class _LevelInstructionState extends State<LevelInstruction> {
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: size.height / 1.5,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          'Nâng level thế nào?',
          style: textTheme.titleMedium,
        ),
        const Text('nội dung nâng level'),
        Container(
          width: double.infinity,
          child: AppIconButton(
            onPressed: () {
              context.pop();
            },
            title: 'Tôi đã hiểu',
          ),
        )
      ]),
    );
  }
}
