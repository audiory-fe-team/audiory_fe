import 'dart:math';

import 'package:audiory_v0/feat-write/widgets/story_card_detail_writer.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/state/state_manager.dart';
import 'package:audiory_v0/widgets/buttons/icon_button.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../repositories/auth.repository.dart';
import '../../theme/theme_constants.dart';
import '../../widgets/custom_app_bar.dart';

class WriterScreen extends ConsumerStatefulWidget {
  const WriterScreen({super.key});

  @override
  ConsumerState<WriterScreen> createState() => _WriterScreenState();
}

class _WriterScreenState extends ConsumerState<WriterScreen> {
  final User? authUser = AuthRepository().currentUser;
  @override
  void initState() {
    if (kDebugMode) {
      print('init');
    }
    ref.read(storyOfUserProvider);
    super.initState();
  }

  @override
  void dispose() {
    ref.invalidate(storyOfUserProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final AsyncValue<List<Story>> storyList = ref.watch(storyOfUserProvider);
    // ref.invalidate(storyOfUserProvider);
    return authUser != null
        ? Scaffold(
            appBar: CustomAppBar(
              height: 60,
              title: Text(
                'Tác phẩm',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: appColors.inkBase),
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.pie_chart_outline_rounded,
                      size: 30,
                    ))
              ],
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      FormBuilder(
                          child: AppTextInputField(
                        name: 'title',
                        hintText: 'Tác phẩm',
                        prefixIcon: Icon(
                          Icons.search,
                          color: appColors.skyDark,
                        ),
                      )),
                      const SizedBox(height: 16),
                      storyList.when(
                          data: (storyList) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${storyList.length} tác phẩm',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true, //fix error
                                      itemCount: storyList.length,
                                      itemBuilder: ((context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 16.0),
                                          child: StoryCardDetailWriter(
                                              story: storyList[index]),
                                        );
                                      })),
                                ],
                              ),
                          error: (err, stack) => Text(err.toString()),
                          loading: () => const Center(
                                child: CircularProgressIndicator(),
                              )),
                    ],
                  )),
            ),
            floatingActionButton: AppIconButton(
              title: 'Viết truyện',
              textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: appColors.skyLightest, fontWeight: FontWeight.w700),
              onPressed: () {
                context.pushNamed('composeStory', extra: {'storyId': ''});
              },
              icon: const Icon(Icons.edit_outlined),
              iconPosition: 'start',
            ),
          )
        : Scaffold(
            appBar: CustomAppBar(
              height: 60,
              title: Text(
                'Tác phẩm',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: appColors.inkBase),
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.dashboard_outlined,
                      size: 30,
                    ))
              ],
            ),
            body: const Center(
              child: Text('Đăng nhập để viết'),
            ),
          );
  }
}
