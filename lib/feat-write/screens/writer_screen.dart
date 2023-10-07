import 'dart:convert';

import 'package:audiory_v0/feat-write/widgets/story_card_detail_writer.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import '../../models/AuthUser.dart';
import '../../state/state_manager.dart';
import '../../theme/theme_constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../provider/story_state_provider.dart';

class WriterScreen extends ConsumerStatefulWidget {
  const WriterScreen({super.key});

  @override
  ConsumerState<WriterScreen> createState() => _WriterScreenState();
}

class _WriterScreenState extends ConsumerState<WriterScreen> {
  final storage = const FlutterSecureStorage();
  UserServer? currentUser;
  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<UserServer?> getUserDetails() async {
    String? value = await storage.read(key: 'currentUser');
    currentUser =
        value != null ? UserServer.fromJson(jsonDecode(value)['data']) : null;

    if (kDebugMode) {
      print('currentuser ${currentUser?.email}');
    }
    return currentUser;
  }

  @override
  void dispose() {
    ref.invalidate(storyOfUserProvider);
    super.dispose();
  }

  Widget _storiesList(String userId, AsyncValue<List<Story>?> storiesOfUser) {
    return storiesOfUser.when(
        data: (stories) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${stories?.length} tác phẩm',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true, //fix error
                    itemCount: stories?.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          children: [
                            StoryCardDetailWriter(story: stories![index]),
                          ],
                        ),
                      );
                    })),
              ],
            ),
        error: (err, stack) => Text(err.toString()),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final storiesByUser = ref.watch(storyDataProvider);

    // ref.invalidate(storyOfUserProvider);
    return FutureBuilder<UserServer?>(
      future: getUserDetails(), // async work
      builder: (BuildContext context, AsyncSnapshot<UserServer?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError) {
              return Scaffold(
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
            } else {
              // final AsyncValue<List<Story>> storyList =
              //     ref.watch(storyOfUserProvider(snapshot.data?.id as String));

              return Scaffold(
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
                          Icons.bar_chart_outlined,
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
                        AppIconButton(
                            title: 'Cập nhật',
                            onPressed: () async {
                              ref
                                  .read(storyDataProvider.notifier)
                                  .fetchStoriesByUserId(
                                      snapshot.data?.id as String);
                            }),
                        _storiesList(
                            snapshot.data?.id as String, storiesByUser),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: AppIconButton(
                  title: 'Viết truyện',
                  textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: appColors.skyLightest,
                      fontWeight: FontWeight.w700),
                  onPressed: () {
                    context.pushNamed('composeStory', extra: {'storyId': ''});
                  },
                  icon: const Icon(Icons.edit_outlined),
                  iconPosition: 'start',
                ),
              );
            }
        }
      },
    );
  }
}
