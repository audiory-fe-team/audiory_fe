import 'dart:async';

import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-read/screens/detail-story/detail_story_bottom_bar.dart';
import 'package:audiory_v0/feat-read/screens/detail-story/detail_story_top_bar.dart';
import 'package:audiory_v0/feat-read/screens/detail-story/story_chapter_tab.dart';
import 'package:audiory_v0/feat-read/screens/detail-story/story_detail_tab.dart';
import 'package:audiory_v0/models/enum/SnackbarType.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/providers/chapter_database.dart';
import 'package:audiory_v0/providers/connectivity_provider.dart';
import 'package:audiory_v0/providers/story_database.dart';
import 'package:audiory_v0/repositories/library_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/fake_string_generator.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:audiory_v0/widgets/story_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DetailStoryScreen extends HookConsumerWidget {
  final String id;

  @override
  DetailStoryScreen({this.id = '', super.key});

  final storyDb = StoryDatabase();
  final chapterDb = ChapterDatabase();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final isOffline = ref.read(isOfflineProvider);
    final textTheme = Theme.of(context).textTheme;
    final tabController = useTabController(initialLength: 2);

    final libraryQuery = useQuery(
        ['library'], () => LibraryRepository.fetchMyLibrary(),
        enabled: !isOffline);

    final tabState = useState(0);
    final storyQuery = useQuery(
        ['story', id], () => StoryRepostitory().fetchStoryById(id),
        enabled: !isOffline);
    final storyOffline = useFuture<Story?>(
        Future<Story?>.value(isOffline ? storyDb.getStory(id) : null));

    Widget interactionInfo(Story? story) {
      final sharedNumberStyle =
          textTheme.titleLarge!.copyWith(color: appColors.inkLight);
      final sharedHeaderStyle = textTheme.titleSmall;
      return IntrinsicHeight(
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Column(
              children: [
                Row(children: [
                  Skeleton.shade(
                      child: Image.asset(
                    'assets/images/chapter_colored.png',
                    width: 16,
                  )),
                  const SizedBox(width: 4),
                  Text(
                    'Chương',
                    style: sharedHeaderStyle,
                  )
                ]),
                const SizedBox(height: 4),
                Text((story?.chapters?.length ?? '1000').toString(),
                    style: sharedNumberStyle)
              ],
            ),
            const VerticalDivider(),
            Column(
              children: [
                Row(children: [
                  Skeleton.shade(
                      child: Image.asset(
                    'assets/images/view_colored.png',
                    width: 16,
                  )),
                  const SizedBox(width: 4),
                  Text(
                    'Lượt đọc',
                    style: sharedHeaderStyle,
                  )
                ]),
                const SizedBox(height: 4),
                Text((story?.readCount ?? '').toString(),
                    style: sharedNumberStyle)
              ],
            ),
            const VerticalDivider(),
            Column(
              children: [
                Row(children: [
                  Skeleton.shade(
                      child: Image.asset(
                    'assets/images/comment_colored.png',
                    width: 16,
                  )),
                  const SizedBox(width: 4),
                  Text(
                    'Bình luận',
                    style: sharedHeaderStyle,
                  )
                ]),
                const SizedBox(height: 4),
                Text((story?.voteCount ?? '').toString(),
                    style: sharedNumberStyle)
              ],
            ),
            const VerticalDivider(),
            Column(
              children: [
                Row(children: [
                  Skeleton.shade(
                      child: Image.asset(
                    'assets/images/vote_colored.png',
                    width: 16,
                  )),
                  const SizedBox(width: 4),
                  Text(
                    'Bình chọn',
                    style: sharedHeaderStyle,
                  )
                ]),
                const SizedBox(height: 4),
                Text((story?.voteCount ?? '').toString(),
                    style: sharedNumberStyle)
              ],
            ),
          ]));
    }

    Widget storyInfo(Story? story) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Skeleton.replace(
                  width: 110,
                  height: 165,
                  child: Container(
                    width: 110,
                    height: 165,
                    decoration: isOffline
                        ? BoxDecoration(
                            color: appColors.primaryLightest,
                          )
                        : BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  story?.coverUrl ?? FALLBACK_IMG_URL),
                              fit: BoxFit.fill,
                            ),
                          ),
                  ))),
          const SizedBox(height: 24),
          Text(
            story?.title ?? '',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      );
    }

    Future<void> handleAddToLibrary() async {
      try {
        await LibraryRepository.addStoryMyLibrary(id);
        AppSnackBar.buildTopSnackBar(context,
            'Thêm truyện vào thư viện thành công', null, SnackBarType.success);
        libraryQuery.refetch();
      } catch (error) {
        AppSnackBar.buildTopSnackBar(
            context, error.toString(), null, SnackBarType.warning);
      }
    }

    Future<void> handleDownloadStory() async {
      try {
        final wholeStory = await LibraryRepository.downloadStory(id);

        // Save to offline database
        final noContentStory = wholeStory.copyWith(
            chapters: wholeStory.chapters
                ?.map((e) => e.copyWith(paragraphs: []))
                .toList());
        await storyDb.saveStory(noContentStory);

        await Future.forEach(wholeStory.chapters ?? [], (element) async {
          await chapterDb.saveChapters(element);
        });

        AppSnackBar.buildTopSnackBar(
            context, 'Tải truyện thành công', null, SnackBarType.success);
      } catch (error) {
        AppSnackBar.buildTopSnackBar(
            context, error.toString(), null, SnackBarType.warning);
      }
    }

    final isLoading = isOffline ? false : storyQuery.isFetching;
    final story = isOffline ? storyOffline.data : storyQuery.data;

    return Scaffold(

        // appBar: AppBar(
        //   elevation: 2,
        //   leading: IconButton(
        //     onPressed: () {
        //       GoRouter.of(context).pop();
        //     },
        //     icon: Icon(Icons.arrow_back, size: 24, color: appColors.inkBase),
        //   ),
        //   leadingWidth: 40,
        //   title: Text(
        //     story?.title ?? 'Loading...',
        //     style: textTheme.titleLarge,
        //     overflow: TextOverflow.ellipsis,
        //   ),
        //   actions: [
        //     IconButton(
        //       onPressed: () {},
        //       icon: Icon(Icons.more_vert_rounded,
        //           size: 24, color: appColors.inkBase),
        //     )
        //   ],
        // ),
        appBar: DetailStoryTopBar(story: story),
        body: Container(
            width: double.infinity,
            child: RefreshIndicator(
                onRefresh: () async {
                  storyQuery.refetch();
                },
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 12),
                      Skeletonizer(
                          enabled: isLoading,
                          child: storyInfo(isLoading ? skeletonStory : story)),

                      const SizedBox(height: 12),
                      //NOTE: Profile image
                      Skeletonizer(
                        enabled: isLoading,
                        child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () async {
                                  // context.go('/profile');
                                },
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Skeleton.shade(
                                          child: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: isOffline
                                            ? BoxDecoration(
                                                color:
                                                    appColors.primaryLightest,
                                                borderRadius:
                                                    BorderRadius.circular(28))
                                            : ShapeDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(story
                                                          ?.author?.avatarUrl ??
                                                      FALLBACK_IMG_URL),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: const CircleBorder(),
                                              ),
                                      )),
                                      const SizedBox(width: 8),
                                      Text(
                                        isLoading
                                            ? generateFakeString(16)
                                            : story?.author?.fullName ??
                                                'Tác giả',
                                        style: textTheme.titleMedium!.copyWith(
                                            fontWeight: FontWeight.w400),
                                      )
                                    ]))),
                      ),
                      const SizedBox(height: 24),
                      Skeletonizer(
                          enabled: isLoading,
                          child: interactionInfo(
                              isLoading ? skeletonStory : story)),
                      const SizedBox(height: 24),
                      Skeletonizer(
                          enabled: isLoading,
                          child: SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 6,
                                runSpacing: 6,
                                children: ((isLoading
                                            ? skeletonStory.tags
                                            : story?.tags) ??
                                        [])
                                    .map((tag) => GestureDetector(
                                        onTap: () {
                                          GoRouter.of(context).go(
                                              '/tag/${tag.id}?tagName=${tag.name}');
                                        },
                                        child: StoryTag(
                                          label: tag.name ?? '',
                                          selected: false,
                                        )))
                                    .toList(),
                              ))),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: TabBar(
                          onTap: (value) {
                            if (tabState.value != value) tabState.value = value;
                          },
                          controller: tabController,
                          labelColor: appColors.inkBase,
                          unselectedLabelColor: appColors.inkLighter,
                          labelPadding: const EdgeInsets.symmetric(vertical: 0),
                          indicatorColor: appColors.primaryBase,
                          indicatorWeight: 2.5,
                          indicatorPadding:
                              const EdgeInsets.symmetric(horizontal: 24),
                          labelStyle: textTheme.headlineSmall,
                          tabs: const [
                            Tab(
                              text: 'Chi tiết',
                              height: 36,
                            ),
                            Tab(
                              text: 'Chương',
                              height: 36,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Builder(builder: (context) {
                        if (tabState.value == 0) {
                          return Skeletonizer(
                              enabled: isLoading,
                              child: StoryDetailTab(
                                  story: isLoading ? skeletonStory : story));
                        }
                        return Skeletonizer(
                            enabled: isLoading,
                            child: StoryChapterTab(
                                story: isLoading ? skeletonStory : story));
                      }),
                    ],
                  ),
                ))),
        bottomNavigationBar: Builder(builder: (context) {
          final isAddedToLibrary = libraryQuery.data?.libraryStory
              ?.any((element) => element.storyId == id);
          return DetailStoryBottomBar(
              storyId: id,
              addToLibraryCallback: () => handleAddToLibrary(),
              downloadStoryCallback: () => handleDownloadStory(),
              isAddedToLibrary: isAddedToLibrary ?? false);
        }));
  }
}
