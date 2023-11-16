import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class BlockAccounts extends StatefulWidget {
  const BlockAccounts({super.key});

  @override
  State<BlockAccounts> createState() => _BlockAccountsState();
}

class _BlockAccountsState extends State<BlockAccounts> {
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Các tài khoản bị chăn',
          style: textTheme.headlineMedium,
        ),
      ),
      body: Column(children: [Text('danh sách')]),
    );
  }
}
