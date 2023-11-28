import 'package:audiory_v0/feat-write/screens/layout/writer_app_bar.dart';
import 'package:audiory_v0/feat-write/widgets/story_card_detail_writer.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  final storage = const FlutterSecureStorage();
  String? jwt;
  UseQueryResult? result;

  final _formKey = GlobalKey<FormBuilderState>();
  Widget _storiesList(UseQueryResult<List<Story>?, dynamic> myStoriesQuery,
      List<Story>? filteredList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Skeletonizer(
          enabled: myStoriesQuery.isFetching,
          child: Text(
            '${filteredList?.length} tác phẩm',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Skeletonizer(
          enabled: myStoriesQuery.isFetching,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true, //fix error
              itemCount: filteredList?.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    children: [
                      StoryCardDetailWriter(
                        story: filteredList?[index],
                        callBackRefetch: () {
                          myStoriesQuery.refetch();
                        },
                      ),
                    ],
                  ),
                );
              })),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final myStoriesQuery = useQuery(
        ['myStories', jwt], () => StoryRepostitory().fetchMyStories(),
        refetchOnMount: RefetchOnMount.stale,
        staleDuration: const Duration(minutes: 5)); //userId=me
    final filteredStories = _formKey.currentState?.fields['search']?.value == ''
        ? (myStoriesQuery.data ?? [])
        : (myStoriesQuery.data ?? []).where((element) =>
            element.title?.toLowerCase().contains(
                _formKey.currentState?.fields['search']?.value ?? '') ??
            false);

    if (myStoriesQuery != result) {
      setState(() {
        result = myStoriesQuery;
      });
    }
    return Scaffold(
      appBar: WriterCustomAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          myStoriesQuery.refetch();
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
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
                _storiesList(myStoriesQuery, filteredStories.toList()),
              ],
            ),
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
