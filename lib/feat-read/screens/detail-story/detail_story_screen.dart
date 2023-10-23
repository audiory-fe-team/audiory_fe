import 'dart:async';
import 'dart:math';

import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-read/widgets/donate_gift_modal.dart';
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
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/buttons/tap_effect_wrapper.dart';
import 'package:audiory_v0/widgets/cards/donate_item_card.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:audiory_v0/widgets/story_tag.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:sembast/sembast.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:readmore/readmore.dart';

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

    final paginatorController = NumberPaginatorController();
    final numOfPages = useState(1);
    final currentPage = useState(0);
    final isDesc = useState(false);

    final storyQuery =
        useQuery(['story', id], () => StoryRepostitory().fetchStoryById(id));

    final donatorsQuery = useQuery(
        ['donators', id], () => StoryRepostitory().fetchTopDonators(id));

    final libraryQuery =
        useQuery(['library'], () => LibraryRepository.fetchMyLibrary());

    final authorQuery = useQuery(['profile', storyQuery.data?.authorId],
        () => ProfileRepository().fetchProfileById(storyQuery.data?.authorId),
        enabled: storyQuery.isSuccess);

    final userQuery = useQuery([
      'userById',
      storyQuery.data?.authorId
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

    void handleBuyChapter(Chapter chapter, int price) {
      if (price != 0) {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          ),
          context: context,
          builder: (context) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            height: MediaQuery.of(context).size.height / 3,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: size.width / 3.7,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: appColors.skyLightest,
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
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
                height: (size.height) / 4.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(chapter.title, style: textTheme.titleLarge),
                    Text('Chương ${chapter.position}',
                        style: textTheme.titleLarge),
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
                    Container(
                      width: size.width - 32,
                      child: AppIconButton(
                        onPressed: () async {
                          var totalCoins =
                              userQuery.data?.wallets?.isEmpty == true
                                  ? 0
                                  : userQuery.data?.wallets?[0].balance;
                          if (price > totalCoins) {
                            context.pop();
                            await AppSnackBar.buildTopSnackBar(context,
                                'Nạp xu để tiếp tục', null, SnackBarType.info);
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
                              await AppSnackBar.buildTopSnackBar(context,
                                  'Mua chương lỗi', null, SnackBarType.error);
                            }
                            // ignore: use_build_context_synchronously
                            context.pop();
                            storyQuery.refetch();
                            userQuery.refetch();

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
                    )
                  ],
                ),
              )
            ]),
          ),
        );
      }
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
                Skeleton.keep(
                  child: Row(children: [
                    Image.asset(
                      'assets/images/chapter_colored.png',
                      width: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Chương',
                      style: sharedHeaderStyle,
                    )
                  ]),
                ),
                const SizedBox(height: 4),
                Text((story?.chapters?.length ?? '1000').toString(),
                    style: sharedNumberStyle)
              ],
            ),
            const VerticalDivider(),
            Column(
              children: [
                Skeleton.keep(
                  child: Row(children: [
                    Image.asset(
                      'assets/images/view_colored.png',
                      width: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Lượt đọc',
                      style: sharedHeaderStyle,
                    )
                  ]),
                ),
                const SizedBox(height: 4),
                Text((story?.readCount ?? '').toString(),
                    style: sharedNumberStyle)
              ],
            ),
            const VerticalDivider(),
            Column(
              children: [
                Skeleton.keep(
                  child: Row(children: [
                    Image.asset(
                      'assets/images/comment_colored.png',
                      width: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Bình luận',
                      style: sharedHeaderStyle,
                    )
                  ]),
                ),
                const SizedBox(height: 4),
                Text((story?.voteCount ?? '').toString(),
                    style: sharedNumberStyle)
              ],
            ),
            const VerticalDivider(),
            Column(
              children: [
                Skeleton.keep(
                  child: Row(children: [
                    Image.asset(
                      'assets/images/vote_colored.png',
                      width: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Bình chọn',
                      style: sharedHeaderStyle,
                    )
                  ]),
                ),
                const SizedBox(height: 4),
                Text((story?.voteCount ?? '').toString(),
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
      handleBuyStory() async {
        //check if paid chapters left >1 chapter

        try {
          await StoryRepostitory().buyStory(story?.id);
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

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Skeleton.replace(
              width: 110,
              height: 165,
              child: Container(
                width: 110,
                height: 165,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        story?.coverUrl == null || story?.coverUrl == ''
                            ? FALLBACK_IMG_URL
                            : story?.coverUrl ?? FALLBACK_IMG_URL),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              )),
          const SizedBox(height: 24),
          Text(
            story?.title ?? '',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          story?.isPaywalled == true && paywalledChaptersList.length >= 5
              ? Column(
                  children: [
                    const SizedBox(height: 24),
                    AppIconButton(
                      onPressed: () {
                        handleBuyStory();
                      },
                      title: 'Mua cả truyện',
                      isOutlined: true,
                      color: appColors.primaryBase,
                      bgColor: appColors.skyLightest,
                    ),
                  ],
                )
              : story?.isPaywalled == true
                  ? Column(
                      children: [
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: ShapeDecoration(
                            color: appColors.primaryLightest,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Truyện trả phí ',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: appColors.primaryBase,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.visible),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 0,
                    )
        ],
      );
    }

    Widget chapterView(
      Story? story,
    ) {
      List<Chapter> chaptersList = story?.chapters ?? [];
      numOfPages.value = (chaptersList.length / 10).ceil();

      var pages = List.generate(
        numOfPages.value,
        (index) => Column(
          children: [
            Column(
              children:
                  (isDesc.value ? chaptersList.reversed.toList() : chaptersList)
                      .getRange(
                          currentPage.value * 10,
                          currentPage.value + 1 == numOfPages.value
                              ? currentPage.value * 10 +
                                  min(10, chaptersList.length.remainder(10))
                              : currentPage.value * 10 + 10)
                      .toList()
                      .asMap()
                      .entries
                      .map((entry) {
                Chapter chapter = entry.value;
                int index = isDesc.value
                    ? chaptersList.length -
                        1 -
                        (entry.key + currentPage.value * 10)
                    : entry.key + currentPage.value * 10;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ChapterItem(
                    onSelected: (chapter, price) {
                      handleBuyChapter(chapter, price);
                    },
                    storyId: story?.id ?? '',
                    chapter: chapter,

                    position: index + 1,
                    title: chapter.title,
                    time: chapter.createdDate ?? DateTime.now().toString(),
                    //ispaywalled
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cập nhật đến chương',
                style: textTheme.headlineSmall,
              ),
              IntrinsicHeight(
                child: Row(children: [
                  TapEffectWrapper(
                    onTap: () {
                      isDesc.value = !isDesc.value;
                    },
                    child: Text(
                        isDesc.value ? 'Đọc chương mới nhất' : 'Đọc từ cũ nhất',
                        style: textTheme.titleSmall
                            ?.copyWith(color: appColors.primaryBase)),
                  ),
                  // const VerticalDivider(),
                  // GestureDetector(
                  //     onTap: () {
                  //       isDesc.value = false;
                  //     },
                  //     child: Text('Cũ nhất', style: textTheme.labelLarge)),
                ]),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            child: pages[currentPage.value],
          ),
          Center(
            child: SizedBox(
              width: numOfPages.value <= 4 ? size.width / 2 : double.infinity,
              child: NumberPaginator(
                config: NumberPaginatorUIConfig(
                  buttonSelectedBackgroundColor: appColors.primaryBase,
                  buttonUnselectedForegroundColor: appColors.primaryBase,
                ),
                controller: paginatorController,
                numberPages: numOfPages.value,
                onPageChange: (index) {
                  currentPage.value = index;
                },
              ),
            ),
          )
        ],
      );
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

    Widget detailView(Story? story) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Giới thiệu', style: textTheme.headlineSmall),
          const SizedBox(
            height: 8,
          ),
          ReadMoreText(
            story?.description ?? '',
            trimLines: 4,
            colorClickableText: appColors.primaryBase,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' Xem thêm',
            trimExpandedText: ' Ẩn bớt',
            style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontFamily: GoogleFonts.sourceSansPro().fontFamily),
            moreStyle:
                textTheme.titleMedium?.copyWith(color: appColors.primaryBase),
          ),
          const SizedBox(
            height: 24,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Người ủng hộ',
                style: textTheme.headlineSmall,
              ),
              SizedBox(
                height: 34,
                child: AppIconButton(
                    title: 'Tặng quà',
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: appColors.primaryBase),
                    icon: Icon(
                      Icons.card_giftcard,
                      color: appColors.primaryBase,
                      size: 14,
                    ),
                    iconPosition: 'start',
                    color: appColors.primaryBase,
                    bgColor: appColors.primaryLightest,
                    onPressed: () => {
                          showModalBottomSheet(
                              barrierColor: Colors.black.withAlpha(1),
                              // backgroundColor: Colors.transparent,
                              context: context,
                              builder: (BuildContext context) {
                                return DonateGiftModal(
                                  coinsWallet: double.parse(handleCoins()),
                                  story: story,
                                  handleSending: (selected, count) {
                                    handleSendingGift(selected, count);
                                  },
                                );
                              })
                        }),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Skeletonizer(
              enabled: donatorsQuery.isFetching,
              child: donatorsView(donatorsQuery.data ?? [])),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bình luận nổi bật',
                style: textTheme.headlineSmall,
              ),
              GestureDetector(
                child: SvgPicture.asset(
                  'assets/icons/right-arrow.svg',
                  width: 24,
                  height: 24,
                  color: appColors.inkDark,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          // _commentList()
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

    final isLoading = false;
    // ? storyOffline.connectionState == ConnectionState.waiting
    // : storyQuery.isFetching;
    final story = storyQuery.data;

    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: Icon(Icons.arrow_back, size: 24, color: appColors.inkBase),
          ),
          leadingWidth: 40,
          title: Container(
              //no flexible here
              color: Colors.amber,
              child: Text(
                story?.title ?? 'Loading...',
                style: textTheme.titleLarge,
              )),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert_rounded,
                  size: 24, color: appColors.inkBase),
            )
          ],
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              storyQuery.refetch();
              donatorsQuery.refetch();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
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
                          child: InkWell(
                              onTap: () async {
                                // context.go('/profile');
                              },
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Skeleton.replace(
                                        width: 32,
                                        height: 32,
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: ShapeDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  story?.author?.avatarUrl ??
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
                      child: TabBar(
                        onTap: (value) {
                          if (tabState.value != value) tabState.value = value;
                        },
                        controller: tabController,
                        labelColor: appColors.primaryBase,
                        unselectedLabelColor: appColors.inkLight,
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        indicatorColor: appColors.primaryBase,
                        labelStyle: textTheme.titleLarge,
                        tabs: const [
                          Tab(
                            text: 'Chi tiết',
                          ),
                          Tab(
                            text: 'Chương',
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Builder(builder: (context) {
                      if (tabState.value == 0) {
                        return Skeletonizer(
                            enabled: isLoading,
                            child:
                                detailView(isLoading ? skeletonStory : story));
                      }
                      return Skeletonizer(
                          enabled: isLoading,
                          child:
                              chapterView(isLoading ? skeletonStory : story));
                    }),
                  ],
                ),
              ),
            )),
        bottomNavigationBar: Material(
            elevation: 10,
            child: Container(
              height: 65,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(builder: (context) {
                    final isAdded = libraryQuery.data?.libraryStory
                        ?.any((element) => element.storyId == id);
                    return TapEffectWrapper(
                        onTap: () {
                          if (isAdded == true) {
                            AppSnackBar.buildTopSnackBar(context,
                                'Đã lưu truyện', null, SnackBarType.info);
                            return;
                          }
                          handleAddToLibrary();
                        },
                        child: SizedBox(
                            width: 50,
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.bookmark_rounded,
                                    size: 24,
                                    color: isAdded == true
                                        ? appColors.primaryBase
                                        : appColors.skyBase,
                                  ),
                                  Text('Lưu trữ',
                                      style: textTheme.labelLarge!.copyWith(
                                        color: isAdded == true
                                            ? appColors.primaryBase
                                            : appColors.skyBase,
                                      ))
                                ])));
                  }),
                  FutureBuilder(
                      future: storyDb.getStory(id),
                      builder: (context, snapshot) {
                        final isDownloaded = snapshot.data != null;
                        return TapEffectWrapper(
                            onTap: () {
                              if (isDownloaded == true) {
                                AppSnackBar.buildTopSnackBar(context,
                                    'Đã tải truyện', null, SnackBarType.info);
                                return;
                              }
                              handleDownloadStory();
                            },
                            child: SizedBox(
                                width: 50,
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.download_rounded,
                                        size: 24,
                                        color: isDownloaded == true
                                            ? appColors.primaryBase
                                            : appColors.skyBase,
                                      ),
                                      Text('Tải xuống',
                                          style: textTheme.labelLarge!.copyWith(
                                            color: isDownloaded == true
                                                ? appColors.primaryBase
                                                : appColors.skyBase,
                                          ))
                                    ])));
                      }),
                  Flexible(
                      child: FilledButton(
                          onPressed: () {
                            context.push(
                                '/story/$id/chapter/41ccaddf-3b96-11ee-8842-e0d4e8a18075');
                            //   .pushNamed("chapter_detail", pathParameters: {
                            // "storyId": id,
                            // "chapterId":
                            //     // story?.chapters?[0].id ?? ''
                            //     '41ccaddf-3b96-11ee-8842-e0d4e8a18075'
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  appColors.primaryBase)),
                          child: Text(
                            'Đọc',
                            style: textTheme.titleMedium!
                                .copyWith(color: Colors.white),
                          )))
                ],
              ),
            )));
  }
}
