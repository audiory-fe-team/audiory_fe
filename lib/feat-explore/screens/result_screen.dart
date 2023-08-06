import 'package:audiory_v0/feat-explore/screens/layout/result_top_bar.dart';
import 'package:audiory_v0/feat-explore/screens/layout/search_top_bar.dart';
import 'package:audiory_v0/layout/bottom_bar.dart';
import 'package:audiory_v0/theme/theme_constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ResultScreen extends HookWidget {
  final String keyword;
  const ResultScreen({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      appBar: ResultTopBar(keyword: keyword),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(children: []))),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }
}
