import 'dart:async';

import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-read/screens/detail-story/buy_chapter_modal.dart';
import 'package:audiory_v0/feat-read/screens/detail-story/detail_story_bottom_bar.dart';
import 'package:audiory_v0/feat-read/screens/detail-story/detail_story_top_bar.dart';
import 'package:audiory_v0/feat-read/screens/detail-story/story_chapter_tab.dart';
import 'package:audiory_v0/feat-read/screens/detail-story/story_detail_tab.dart';
import 'package:audiory_v0/feat-read/screens/reading/audio_bottom_bar.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/models/wallet/wallet_model.dart';
import 'package:audiory_v0/providers/chapter_database.dart';
import 'package:audiory_v0/providers/connectivity_provider.dart';
import 'package:audiory_v0/providers/story_database.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/repositories/chapter_repository.dart';
import 'package:audiory_v0/repositories/library_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/fake_string_generator.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:audiory_v0/widgets/app_image.dart';
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

    final libraryQuery =
        useQuery(['library'], () => LibraryRepository.fetchMyLibrary());

    final storyQuery = useQuery(
        ['story', id], () => StoryRepostitory().fetchStoryById(id),
        enabled: !isOffline);

    final userQuery = useQuery([
      'userById',
    ], () => AuthRepository().getMyUserById(), enabled: storyQuery.isSuccess);

    final tabState = useState(0);
    final storyOffline = useFuture<Story?>(
        Future<Story?>.value(isOffline ? storyDb.getStory(id) : null));

    String handleCoins() {
      List<Wallet>? wallets = userQuery.data?.wallets;
      String coin =
          double.parse(wallets![0].balance.toString()).toStringAsFixed(0);
      return coin;
    }

    handleBuyStory() async {
      //check if paid chapters left >5 chapter
      try {
        await StoryRepostitory().buyStory(id);
      } catch (e) {
        // ignore: use_build_context_synchronously
        AppSnackBar.buildTopSnackBar(
            context, 'Mua truyện không thành công', null, SnackBarType.error);
      }

      storyQuery.refetch();
      // ignore: use_build_context_synchronously
      AppSnackBar.buildTopSnackBar(
          context, 'Mua truyện thành công', null, SnackBarType.success);
    }

    Future<void> handleBuyChapter(
      String chapterId,
      int price,
    ) async {
      var totalCoins = userQuery.data?.wallets?.isEmpty == true
          ? 0
          : userQuery.data?.wallets?[0].balance;
      if (price > totalCoins) {
        context.pop();
        await AppSnackBar.buildTopSnackBar(
            context, 'Nạp xu để tiếp tục', null, SnackBarType.info);
      } else {
        Map<String, String> body = {
          'author_id': storyQuery.data?.authorId ?? ''
        };
        try {
          await ChapterRepository()
              .buyChapter(storyQuery.data?.id, chapterId, body);

          // ignore: use_build_context_synchronously
          await AppSnackBar.buildTopSnackBar(
              context, 'Mua chương thành công', null, SnackBarType.success);

          storyQuery.refetch();
          userQuery.refetch();
        } catch (e) {
          // ignore: use_build_context_synchronously
          await AppSnackBar.buildTopSnackBar(
              context, 'Mua chương lỗi', null, SnackBarType.error);
        }
        // ignore: use_build_context_synchronously
        context.pop();
      }
    }

    void openBuyChapterModal(
        Chapter chapter, int price, int paywalledChaptersCount) {
      bool isBuyStory = paywalledChaptersCount >= 5 ? true : false;
      if (price != 0) {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          ),
          context: context,
          builder: (context) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              height: isBuyStory
                  ? MediaQuery.of(context).size.height / 2.5
                  : MediaQuery.of(context).size.height / 3,
              child: BuyChapterModal(
                  handleBuyStory: () {
                    handleBuyStory();
                  },
                  handleBuyChapter: (chapterId) {
                    handleBuyChapter(chapterId, price);
                  },
                  chapter: chapter,
                  paywalledChaptersCount: paywalledChaptersCount)),
        );
      }
    }

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
                Text((formatNumber(story?.chapters?.length ?? 0)),
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
                Text(formatNumber(story?.readCount ?? 0),
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
                Text(formatNumber(story?.voteCount ?? 0),
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
                Text(formatNumber(story?.voteCount ?? 0),
                    style: sharedNumberStyle)
              ],
            ),
          ]));
    }

    Widget storyInfo(Story? story) {
      List<Chapter> chaptersList = story?.chapters ?? [];
      List<Chapter> paywalledChaptersList = chaptersList.isNotEmpty
          ? chaptersList
              .where((chapter) =>
                  chapter.isPaywalled == true || chapter.isPaid == false)
              .toList()
          : [];

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Skeleton.shade(
                child: AppImage(
                    url: story?.coverUrl,
                    width: 110,
                    height: 165,
                    fit: BoxFit.fill),
              )),
          const SizedBox(height: 24),
          Text(
            story?.title ?? '',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      );
    }

    handleAddToLibrary() async {
      try {
        await LibraryRepository.addStoryMyLibrary(id);
        AppSnackBar.buildTopSnackBar(context,
            'Thêm truyện vào thư viện thành công', null, SnackBarType.success);
        libraryQuery.refetch();
      } catch (error) {
        AppSnackBar.buildTopSnackBar(
            context,
            'Thêm truyện không thành công, thử lại sau',
            null,
            SnackBarType.error);
      }
    }

    handleRemoveFromLibrary() async {
      try {
        await LibraryRepository.deleteStoryFromMyLibrary(id);
        AppSnackBar.buildTopSnackBar(context,
            'Bỏ truyện khỏi thư viện thành công', null, SnackBarType.success);
        libraryQuery.refetch();
      } catch (error) {
        AppSnackBar.buildTopSnackBar(
            context, 'Không bỏ được, thử lại sau', null, SnackBarType.error);
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
                                if (isOffline == false) {
                                  context.push(
                                      '/accountProfile/${story?.authorId}',
                                      extra: {
                                        'name': story?.author?.fullName,
                                        'avatar': story?.author?.avatarUrl,
                                      });
                                }
                              },
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Skeleton.shade(
                                          child: AppImage(
                                            url: story?.author?.avatarUrl,
                                            fit: BoxFit.fill,
                                            width: 32,
                                            height: 32,
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
                    const SizedBox(height: 12),
                    story?.isPaywalled == true
                        ? Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: ShapeDecoration(
                                  color: appColors.primaryLightest,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text('Truyện trả phí ',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: appColors.inkBase,
                                        )),
                              ),
                              const SizedBox(height: 12),
                            ],
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    Skeletonizer(
                        enabled: isLoading,
                        child:
                            interactionInfo(isLoading ? skeletonStory : story)),
                    const SizedBox(height: 24),
                    Skeletonizer(
                        enabled: isLoading,
                        child: SizedBox(
                            width: double.infinity,
                            child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 6,
                                runSpacing: 6,
                                children: [
                                  if (story?.isCompleted == true)
                                    const StoryTag(
                                      label: 'Hoàn thành',
                                      selected: true,
                                    ),
                                  ...((isLoading
                                              ? skeletonStory.tags
                                              : story?.tags) ??
                                          [])
                                      .map((tag) => GestureDetector(
                                          onTap: () {
                                            print("tag screen");
                                            context.push(
                                                '/story/${story?.id}/tag/${tag.id}?tagName=${tag.name}');
                                          },
                                          child: StoryTag(
                                            label: tag.name ?? '',
                                            selected: false,
                                          )))
                                      .toList(),
                                ]))),
                    Skeletonizer(
                        enabled: isLoading,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TabBar(
                            onTap: (value) {
                              if (tabState.value != value)
                                tabState.value = value;
                            },
                            controller: tabController,
                            labelColor: appColors.inkBase,
                            unselectedLabelColor: appColors.inkLighter,
                            labelPadding:
                                const EdgeInsets.symmetric(vertical: 0),
                            indicatorColor: appColors.primaryBase,
                            indicatorWeight: 2.5,
                            indicatorPadding:
                                const EdgeInsets.symmetric(horizontal: 24),
                            labelStyle: textTheme.headlineSmall,
                            tabs: const [
                              Tab(
                                height: 36,
                                child: Text('Chi tiết'),
                              ),
                              Tab(
                                height: 36,
                                child: Text('Chương'),
                              )
                            ],
                          ),
                        )),
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
                              handleBuyChapter:
                                  (chapter, price, paywalledChaptersCount) {
                                openBuyChapterModal(
                                    chapter, price, paywalledChaptersCount);
                              },
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
            addToLibraryCallback: () => isAddedToLibrary == true
                ? handleRemoveFromLibrary()
                : handleAddToLibrary(),
            downloadStoryCallback: () => handleDownloadStory(),
            isAddedToLibrary: isAddedToLibrary ?? false);
      }),
      floatingActionButton: const AudioBottomBar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
