import 'package:audiory_v0/repositories/interaction_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';

class MuteAccountsScreen extends StatefulHookWidget {
  const MuteAccountsScreen({super.key});

  @override
  State<MuteAccountsScreen> createState() => _MuteAccountsScreenState();
}

class _MuteAccountsScreenState extends State<MuteAccountsScreen> {
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final muteAccounts = useQuery(
        ['myMutedAccounts'], () => InteractionRepository().getMutedAccounts());

    return Scaffold(
      appBar: CustomAppBar(
          title: Text(
        'Danh sách ngừng tương tác',
        style: textTheme.headlineMedium,
      )),
      body: Column(children: [
        Text('danh sách'),
        Container(
          height: size.height - 50,
          child: ListView.builder(
              itemCount: muteAccounts.data?.length,
              itemBuilder: (context, index) {
                return Text(
                    muteAccounts.data?[index]?.username ?? 'nguoi dung');
              }),
        )
      ]),
    );
  }
}
