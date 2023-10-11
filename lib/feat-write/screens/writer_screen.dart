import 'package:audiory_v0/feat-write/widgets/story_card_detail_writer.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../theme/theme_constants.dart';
import '../../widgets/custom_app_bar.dart';

class WriterScreen extends StatefulHookWidget {
  const WriterScreen({super.key});

  @override
  State<WriterScreen> createState() => _WriterScreenState();
}

class _WriterScreenState extends State<WriterScreen> {
  Widget _storiesList(
    UseQueryResult<List<Story>?, dynamic> myStoriesQuery,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Skeletonizer(
          enabled: myStoriesQuery.isFetching,
          child: Text(
            '${myStoriesQuery.data?.length} tác phẩm',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true, //fix error
            itemCount: myStoriesQuery.data?.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  children: [
                    StoryCardDetailWriter(story: myStoriesQuery.data?[index]),
                  ],
                ),
              );
            })),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final myStoriesQuery = useQuery(
        ['myStories'], () => StoryRepostitory().fetchMyStories()); //userId=me
    // ref.invalidate(storyOfUserProvider);
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
              _storiesList(myStoriesQuery),
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
        icon: const Icon(Icons.edit_outlined),
        iconPosition: 'start',
      ),
    );
  }
}
