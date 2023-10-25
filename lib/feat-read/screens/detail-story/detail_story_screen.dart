import 'dart:async';
import 'dart:math';

import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-read/screens/detail-story/detail_story_bottom_bar.dart';
import 'package:audiory_v0/feat-read/screens/detail-story/detail_story_top_bar.dart';
import 'package:audiory_v0/feat-read/screens/detail-story/story_chapter_tab.dart';
import 'package:audiory_v0/feat-read/screens/detail-story/story_detail_tab.dart';
import 'package:audiory_v0/feat-read/screens/detail-story/donate_gift_modal.dart';
import 'package:audiory_v0/feat-read/widgets/chapter_item.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/gift/gift_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/models/wallet/wallet_model.dart';
import 'package:audiory_v0/providers/chapter_database.dart';
import 'package:audiory_v0/providers/connectivity_provider.dart';
import 'package:audiory_v0/providers/story_database.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/repositories/chapter_repository.dart';
import 'package:audiory_v0/repositories/gift_repository.dart';
import 'package:audiory_v0/repositories/library_repository.dart';
import 'package:audiory_v0/repositories/profile_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/fake_string_generator.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/buttons/tap_effect_wrapper.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:audiory_v0/widgets/story_tag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:readmore/readmore.dart';
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
    final size = MediaQuery.of(context).size;

    final tabController = useTabController(initialLength: 2);

    final donatorsQuery = useQuery(
        ['donators', id], () => StoryRepostitory().fetchTopDonators(id));

    final libraryQuery =
        useQuery(['library'], () => LibraryRepository.fetchMyLibrary());

    final storyQuery = useQuery(
        ['story', id], () => StoryRepostitory().fetchStoryById(id),
        enabled: !isOffline);
    final authorQuery = useQuery(['profile', storyQuery.data?.authorId],
        () => ProfileRepository().fetchProfileById(storyQuery.data?.authorId),
        enabled: storyQuery.isSuccess);

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

    handleSendingGift(Gift gift, int? count) async {
      if (double.parse('${gift.price}') > double.parse('${handleCoins()}')) {
        AppSnackBar.buildTopSnackBar(
            context, 'Không đủ số dư', null, SnackBarType.info);
      } else {
        try {
          Map<String, String> body = {
            'product_id': gift.id,
            'author_id': storyQuery.data?.authorId ?? '',
          };
          for (var i = 0; i < int.parse('$count'); i++) {
            await GiftRepository().donateGift(storyQuery.data?.id, body);
          }

          userQuery.refetch();
          donatorsQuery.refetch();
        } catch (e) {
          AppSnackBar.buildTopSnackBar(
              context, 'Tặng quà không thành công', null, SnackBarType.error);
        }

        context.pop();
        AppSnackBar.buildTopSnackBar(
            context,
            'Tặng ${count} ${gift.name} thành công',
            null,
            SnackBarType.success);
      }
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

    void handleBuyChapter(
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width / 3.75,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: appColors.skyLightest,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: GestureDetector(
                          child: Image.asset(
                            'assets/images/coin.png',
                            width: 30,
                            height: 30,
                          ),
                        )),
                        Flexible(
                            child: Skeletonizer(
                          enabled: userQuery.isFetching,
                          child: Text(
                            handleCoins(),
                            style: textTheme.titleMedium
                                ?.copyWith(color: appColors.inkBase),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(chapter.title, style: textTheme.titleLarge),
                        Text('Chương ${chapter.position}',
                            style: textTheme.titleLarge),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 3,
                              child: GestureDetector(
                                child: Image.asset(
                                  'assets/images/coin.png',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Text(
                                '$price',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: appColors.inkLighter),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: size.width - 32,
                          child: AppIconButton(
                            onPressed: () async {
                              var totalCoins =
                                  userQuery.data?.wallets?.isEmpty == true
                                      ? 0
                                      : userQuery.data?.wallets?[0].balance;
                              if (price > totalCoins) {
                                context.pop();
                                await AppSnackBar.buildTopSnackBar(
                                    context,
                                    'Nạp xu để tiếp tục',
                                    null,
                                    SnackBarType.info);
                              } else {
// print('authorId : ${authorQuery.data?.id}');
                                Map<String, String> body = {
                                  // 'transaction':{
                                  //   'author_id': authorQuery.data?.id ?? ''
                                  // }
                                  'author_id': authorQuery.data?.id ?? ''
                                };
                                try {
                                  await ChapterRepository().buyChapter(
                                      storyQuery.data?.id, chapter.id, body);
                                } catch (e) {
                                  if (kDebugMode) {
                                    print('error $e');
                                  }

                                  // ignore: use_build_context_synchronously
                                  await AppSnackBar.buildTopSnackBar(
                                      context,
                                      'Mua chương lỗi',
                                      null,
                                      SnackBarType.error);
                                }
                                // ignore: use_build_context_synchronously
                                context.pop();
                                storyQuery.refetch();
                                userQuery.refetch();

                                // ignore: use_build_context_synchronously
                                await AppSnackBar.buildTopSnackBar(
                                    context,
                                    'Mua chương thành công',
                                    null,
                                    SnackBarType.success);
                              }
                            },
                            title: 'Mở khóa chương',
                            textStyle: textTheme.titleMedium
                                ?.copyWith(color: appColors.skyLightest),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        paywalledChaptersCount >= 5
                            ? SizedBox(
                                width: size.width - 32,
                                child: AppIconButton(
                                  title:
                                      'Mua cả truyện với ${(paywalledChaptersCount * (chapter.price ?? 0) * 0.8).round()} xu',
                                  textStyle: textTheme.titleMedium
                                      ?.copyWith(color: appColors.primaryBase),
                                  isOutlined: true,
                                  bgColor: appColors.skyLightest,
                                  onPressed: () {
                                    handleBuyStory();
                                  },
                                ),
                              )
                            : const SizedBox(
                                height: 0,
                              )
                      ],
                    ),
                  )
                ]),
          ),
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
            context, error.toString(), null, SnackBarType.warning);
      }
    }

    Widget donatorsView(List<Profile> donators) {
      final list = donators;
      final AppColors appColors = Theme.of(context).extension<AppColors>()!;
      final textTheme = Theme.of(context).textTheme;
      //if top donators<3 => column only
      //if top donators>=3 => column(row for top3 and column for others)
      Widget getBadgeWidget(int order) {
        if (order > 3) {
          return SizedBox(
              width: 24,
              height: 24,
              child: Center(
                  child: Text(order.toString(),
                      style: Theme.of(context).textTheme.headlineMedium)));
        }
        String badgePath = '';
        Color bgBadgeColor = appColors.skyLight;
        Color color = appColors.skyLight;
        switch (order) {
          case 1:
            badgePath = 'assets/images/gold_badge.png';
            bgBadgeColor = appColors.secondaryBase;
            break;
          case 2:
            badgePath = 'assets/images/silver_badge.png';
            bgBadgeColor = appColors.primaryLight;
            break;
          case 3:
            badgePath = 'assets/images/bronze_badge.png';
            color = appColors.inkBase;
            break;
        }
        // return SizedBox(
        //   width: 32,
        //   height: 32,
        //   child: Center(
        //       child: Image.asset(
        //     badgePath,
        //     fit: BoxFit.fitWidth,
        //     width: 32,
        //   )),
        // );
        return Container(
          width: order == 1 ? 35 : 30,
          height: order == 1 ? 35 : 30,
          decoration: BoxDecoration(
              color: bgBadgeColor, borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text(
              '$order',
              style: textTheme.headlineSmall?.copyWith(color: color),
            ),
          ),
        );
      }

      Widget topThreeDonatorCard(Profile? donator, int order) {
        double defaultContainerSize = 110;
        Color defaultColor = appColors.skyLight;
        switch (order) {
          case 2:
            defaultContainerSize = 90;
            // defaultColor = appColors.primaryLight;
            break;
          case 3:
            defaultContainerSize = 80;
            // defaultColor = appColors.skyBase;
            break;
          default:
        }
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: defaultContainerSize,
                height: defaultContainerSize,
                child: Stack(alignment: AlignmentDirectional.center, children: [
                  Container(
                    width: defaultContainerSize - 15,
                    height: defaultContainerSize - 15,
                    decoration: BoxDecoration(
                      color: const Color(0xff7c94b6),
                      image: DecorationImage(
                        image: NetworkImage(donator?.avatarUrl == null ||
                                donator?.avatarUrl == ''
                            ? 'https://static.vecteezy.com/system/resources/previews/024/059/039/original/digital-art-of-a-cat-head-cartoon-with-sunglasses-illustration-of-a-feline-avatar-wearing-glasses-vector.jpg'
                            : donator?.avatarUrl ??
                                'https://static.vecteezy.com/system/resources/previews/024/059/039/original/digital-art-of-a-cat-head-cartoon-with-sunglasses-illustration-of-a-feline-avatar-wearing-glasses-vector.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      border: Border.all(
                        color: defaultColor,
                        width: 6.0,
                      ),
                    ),
                  ),
                  Positioned(
                      top: -5,
                      right: -25,
                      child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        shape: const CircleBorder(),
                        // fillColor: Color(0xFFF5F6F9),
                        child: getBadgeWidget(order),
                      )),
                ]),
              ),
              const SizedBox(width: 4),
              Text(
                donator?.fullName ?? 'Ẩn danh',
                style: textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  '${donator?.totalDonation ?? ''} điểm',
                  style:
                      textTheme.bodyMedium?.copyWith(color: appColors.skyDark),
                ),
              ),
            ],
          ),
        );
      }

      Widget donatorCard(Profile? donator, int order) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          width: double.infinity,
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  '${order + 1}',
                  style: textTheme.headlineSmall,
                ),
              ),
              Flexible(
                flex: 4,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(donator?.avatarUrl == ''
                          ? 'https://cdn-prd.content.metamorphosis.com/wp-content/uploads/sites/2/2021/12/shutterstock_1917408059-768x512.jpg'
                          : donator?.avatarUrl ??
                              'https://static.vecteezy.com/system/resources/previews/024/059/039/original/digital-art-of-a-cat-head-cartoon-with-sunglasses-illustration-of-a-feline-avatar-wearing-glasses-vector.jpg'),
                      fit: BoxFit.fill,
                    ),
                    shape: const CircleBorder(),
                  ),
                ),
              ),
              Flexible(
                flex: 12,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          donator?.username ?? 'Ẩn danh',
                          style: textTheme.titleLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
              Flexible(
                flex: 9,
                child: Text(
                  '${donator?.totalDonation ?? ''} điểm',
                  style:
                      textTheme.titleLarge?.copyWith(color: appColors.skyDark),
                ),
              ),
            ],
          ),
        );
      }

      // if (list.length >= 2) {
      //   list.insert(2, list[0]);
      //   list.removeAt(0);
      // }

      return list.isEmpty
          ? const Center(
              child: Text('Chưa có người ủng hộ'),
            )
          : list.length < 3
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: list
                        .getRange(0, list.length)
                        .map((donator) =>
                            donatorCard(donator, list.indexOf(donator)))
                        .toList(),
                  ),
                )
              : Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: list
                            .asMap()
                            .entries
                            .map((entry) {
                              Profile donator = entry.value;
                              int index = entry.key + 1;
                              return index == 1
                                  ? topThreeDonatorCard(list.elementAt(1), 2)
                                  : index == 2
                                      ? topThreeDonatorCard(
                                          list.elementAt(0), 1)
                                      : topThreeDonatorCard(donator, 3);
                            })
                            .take(3)
                            .toList(),
                      ),
                    ),
                    Column(
                      children: list
                          .getRange(3, list.length)
                          .map((donator) =>
                              donatorCard(donator, list.indexOf(donator)))
                          .toList(),
                    ),
                  ],
                );
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
                                },
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
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
                                              GoRouter.of(context).go(
                                                  '/tag/${tag.id}?tagName=${tag.name}');
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
                                  coinsWallets: double.parse(handleCoins()),
                                  story: isLoading ? skeletonStory : story));
                        }
                        return Skeletonizer(
                            enabled: isLoading,
                            child: StoryChapterTab(
                                handleBuyChapter:
                                    (chapter, price, paywalledChaptersCount) {
                                  handleBuyChapter(
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
          print(isAddedToLibrary);
          return DetailStoryBottomBar(
              storyId: id,
              addToLibraryCallback: () => handleAddToLibrary(),
              downloadStoryCallback: () => handleDownloadStory(),
              isAddedToLibrary: isAddedToLibrary ?? false);
        }));
  }
}
