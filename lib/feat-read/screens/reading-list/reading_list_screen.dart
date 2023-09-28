import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-read/screens/library/library_top_bar.dart';
import 'package:audiory_v0/repositories/reading_list_repository.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReadingListScreen extends HookWidget {
  final String id;
  const ReadingListScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final listStoriesQuery = useQuery(['readingList', 'stories', id],
        () => ReadingListRepository.fetchReadingListStoriesById(id));

    final readingListQuery = useQuery(
        ['readingList'], () => ReadingListRepository.fetchMyReadingList());

    final readingListName =
        readingListQuery.data?.firstWhere((element) => element.id == id).name;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const LibraryTopBar(),
        body: Material(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Builder(builder: (context) {
                if (listStoriesQuery.isError) {
                  return Center(
                      child: Text('Đã có lỗi xảy ra. Vui lòng thử lại sau',
                          style: textTheme.titleLarge));
                }
                if (listStoriesQuery.isFetching == false &&
                    (listStoriesQuery.data ?? []).isEmpty) {
                  return Center(
                      child:
                          Text('Danh sách trống', style: textTheme.titleLarge));
                }

                return Skeletonizer(
                    enabled: listStoriesQuery.isFetching,
                    child: RefreshIndicator(
                        onRefresh: () async {
                          listStoriesQuery.refetch();
                          readingListQuery.refetch();
                        },
                        child: ListView(children: [
                          const SizedBox(height: 16),
                          Text(readingListName ?? '',
                              style: textTheme.titleLarge),
                          const SizedBox(height: 4),
                          Text('${listStoriesQuery.data?.length ?? 0} truyện',
                              style: textTheme.titleSmall),
                          const SizedBox(height: 24),
                          ...(listStoriesQuery.isFetching
                                  ? skeletonStories
                                  : (listStoriesQuery.data ?? []))
                              .map((e) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: StoryCardDetail(
                                    story: e,
                                  )))
                              .toList(),
                          const SizedBox(height: 24),
                        ])));
              }),
            )));
  }
}
