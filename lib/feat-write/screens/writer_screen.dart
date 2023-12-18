import 'package:audiory_v0/feat-write/screens/layout/writer_app_bar.dart';
import 'package:audiory_v0/feat-write/widgets/story_card_detail_writer.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/providers/global_me_provider.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../theme/theme_constants.dart';

class WriterScreen extends StatefulHookConsumerWidget {
  const WriterScreen({super.key});

  @override
  ConsumerState<WriterScreen> createState() => _WriterScreenState();
}

class _WriterScreenState extends ConsumerState<WriterScreen> {
  final storage = const FlutterSecureStorage();
  String? jwt;
  UseQueryResult? result;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final currentUserId = ref.watch(globalMeProvider)?.id;
    final myStoriesQuery = useQuery(
        ['myStories', currentUserId], () => StoryRepostitory().fetchMyStories(),
        refetchOnMount: RefetchOnMount.stale,
        staleDuration: const Duration(minutes: 5)); //userId=me
    final searchValue = _formKey.currentState?.fields['search']?.value
            ?.toString()
            .trim()
            .toLowerCase() ??
        '';
    final filteredStories = searchValue == ''
        ? (myStoriesQuery.data ?? [])
        : (myStoriesQuery.data ?? []).where((element) =>
            element.title?.toLowerCase().trim().contains(searchValue) ?? false);

    if (myStoriesQuery != result) {
      setState(() {
        result = myStoriesQuery;
      });
    }
    return Scaffold(
      appBar: const WriterCustomAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          myStoriesQuery.refetch();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              const SizedBox(height: 16),
              FormBuilder(
                  key: _formKey,
                  onChanged: () {
                    setState(() {
                      _formKey.currentState?.save();
                    });
                  },
                  child: AppTextInputField(
                    name: 'search',
                    hintText: 'Tác phẩm',
                    prefixIcon: Icon(
                      Icons.search,
                      color: appColors.skyDark,
                    ),
                  )),
              const SizedBox(height: 16),
              Skeletonizer(
                enabled: myStoriesQuery.isFetching,
                child: Text(
                  '${filteredStories.toList().length} tác phẩm',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Skeletonizer(
                  enabled: myStoriesQuery.isFetching,
                  child: Column(
                      children: filteredStories
                          .map((story) => Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: StoryCardDetailWriter(
                                  story: story,
                                  callBackRefetch: () {
                                    myStoriesQuery.refetch();
                                  },
                                ),
                              ))
                          .toList()))
            ],
          ),
        ),
      ),
      floatingActionButton: AppIconButton(
        title: 'Viết truyện',
        textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: appColors.skyLightest, fontWeight: FontWeight.w700),
        onPressed: () {
          context.pushNamed('composeStory', extra: {'storyId': ''});
        },
        icon: Icon(
          Icons.edit,
          color: appColors.skyLightest,
        ),
        iconPosition: 'start',
      ),
    );
  }
}
