import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:readmore/readmore.dart';
import './donate_gift_modal.dart';

class StoryDetailTab extends StatelessWidget {
  final double? coinsWallets;
  final Story? story;

  const StoryDetailTab({super.key, required this.story, this.coinsWallets});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: appColors.primaryLightest),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                moreStyle: textTheme.titleMedium
                    ?.copyWith(color: appColors.primaryBase),
              )
            ])),
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
                            context: context,
                            builder: (BuildContext context) {
                              return DonateGiftModal(
                                coinsWallet: coinsWallets,
                                story: story,
                                handleSending: (selected, count) {},
                              );
                            })
                      }),
            ),
          ],
        ),
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
}
