import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/models/author_level.dart/author_level_model.dart';
import 'package:audiory_v0/models/level/level_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class LevelBadge extends StatefulWidget {
  final String? name;
  final Color? color;
  const LevelBadge(
      {super.key, this.name = '', this.color = Colors.transparent});

  @override
  State<LevelBadge> createState() => _LevelBadgeState();
}

class _LevelBadgeState extends State<LevelBadge> {
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: widget.color, borderRadius: BorderRadius.circular(12)),
      child: Text(
        widget.name ?? '',
        style: textTheme.titleMedium?.copyWith(),
        textAlign: TextAlign.center,
      ),
    );
  }
}
