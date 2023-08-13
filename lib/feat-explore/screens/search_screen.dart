import 'package:audiory_v0/feat-explore/screens/layout/search_top_bar.dart';
import 'package:audiory_v0/layout/bottom_bar.dart';
import 'package:audiory_v0/theme/theme_constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends HookWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final hotSearch = useState<List<String>>([
      'Harry Potter và những người bạn',
      '[HOT] Mùa hè cuối cùng ta và em',
      '[HOT] Bạch ô',
      '[HOT] Xin hãy bên anh lần nữa',
      '[HOT] Xin hãy bên anh lần nữa',
    ]);

    return Scaffold(
      appBar: const SearchTopBar(),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  const SizedBox(height: 12),
                  Text('Tìm kiếm nổi bật',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: hotSearch.value
                              .map((item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      GoRouter.of(context).goNamed(
                                          'explore_result',
                                          queryParameters: {'keyword': item});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: appColors.skyLightest,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: Text(
                                            item,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          )),
                                    ),
                                  )))
                              .toList())),
                ],
              ))),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }
}
