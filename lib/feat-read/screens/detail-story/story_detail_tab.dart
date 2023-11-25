import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-explore/widgets/story_scroll_list.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/gift/gift_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/repositories/gift_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../models/Profile.dart';
import 'package:readmore/readmore.dart';
import './donate_gift_modal.dart';

class StoryDetailTab extends HookWidget {
  final Story? story;
  final String storyId;

  const StoryDetailTab({super.key, required this.story, required this.storyId});

  @override
  Widget build(BuildContext context) {
    final AppColors? appColors = Theme.of(context).extension<AppColors>();
    final textTheme = Theme.of(context).textTheme;

    final donatorsQuery = useQuery(
      ['donators', storyId],
      () => StoryRepostitory().fetchTopDonators(storyId),
    );
    final userQuery = useQuery([
      'userById',
    ], () => AuthRepository().getMyUserById());
    final similarStories = useQuery(
      ['similarStories', storyId],
      () => StoryRepostitory().fetchSimilarStories(storyId),
    );

    handleSendingGift(Gift gift, total) async {
      var totalCoinsOfUser = userQuery.data?.wallets![0].balance ?? 0;
      if (double.parse('${gift.price! * total}') >
          double.parse(totalCoinsOfUser.toString())) {
        AppSnackBar.buildTopSnackBar(
            context, 'Không đủ số dư', null, SnackBarType.info);
      } else {
        try {
          Map<String, String> body = {
            'product_id': gift.id,
            'author_id': story?.authorId ?? '',
          };
          for (var i = 0; i < total; i++) {
            await GiftRepository().donateGift(story?.id, body);
          }
        } catch (e) {
          // ignore: use_build_context_synchronously
          AppSnackBar.buildTopSnackBar(
              context, 'Tặng quà không thành công', null, SnackBarType.error);
        }

        context.pop();
        AppSnackBar.buildTopSnackBar(context,
            'Tặng $total ${gift.name} thành công', null, SnackBarType.success);
        donatorsQuery.refetch();
        userQuery.refetch(); //refetch coins
      }
    }

    Widget donatorsView(List<Profile> donators) {
      final list = donators;

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
        Color? bgBadgeColor = appColors?.skyLight;
        Color? color = appColors?.skyLight;
        switch (order) {
          case 1:
            bgBadgeColor = appColors?.secondaryBase;
            break;
          case 2:
            bgBadgeColor = appColors?.primaryLight;
            break;
          case 3:
            color = appColors?.inkBase;
            break;
        }

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
        Color defaultColor = appColors?.skyLight ?? Colors.transparent;
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
                      textTheme.bodyMedium?.copyWith(color: appColors?.skyDark),
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
                      textTheme.titleLarge?.copyWith(color: appColors?.skyDark),
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
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Center(
                child: Text('Chưa có người ủng hộ'),
              ))
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Skeleton.shade(
            child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: appColors?.skyLightest),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Giới thiệu', style: textTheme.headlineSmall),
                      const SizedBox(
                        height: 8,
                      ),
                      ReadMoreText(
                        story?.description ?? '',
                        trimLines: 4,
                        colorClickableText: appColors?.primaryBase,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: ' Xem thêm',
                        trimExpandedText: ' Ẩn bớt',
                        style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontFamily: GoogleFonts.sourceSansPro().fontFamily),
                        moreStyle: textTheme.titleMedium
                            ?.copyWith(color: appColors?.primaryBase),
                      )
                    ]))),
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
                      ?.copyWith(color: appColors?.primaryBase),
                  icon: Icon(
                    Icons.card_giftcard,
                    color: appColors?.primaryBase,
                    size: 14,
                  ),
                  iconPosition: 'start',
                  color: appColors?.primaryBase,
                  bgColor: appColors?.primaryLightest,
                  onPressed: () => {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: DonateGiftModal(
                                    handleSendingGift: (gift, count) {
                                      handleSendingGift(gift, count);
                                    },
                                    story: story,
                                    coins: userQuery.data?.wallets?[0].balance,
                                    userData: userQuery.data),
                              );
                            })
                      }),
            ),
          ],
        ),
        donatorsView(donatorsQuery.data ?? []),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Text(
              'Truyện tương tự',
              style: textTheme.headlineSmall,
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Skeletonizer(
            enabled: similarStories.isFetching,
            child: StoryScrollList(
              storyList: similarStories.isFetching
                  ? skeletonStories
                  : similarStories.data,
            )),
        const SizedBox(
          height: 48,
        ),
      ],
    );
  }
}
