import 'package:audiory_v0/feat-manage-profile/screens/wallet/new_purchase_screen.dart';
import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/gift/gift_model.dart';
import 'package:audiory_v0/providers/global_me_provider.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/repositories/gift_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/cards/donate_item_card.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DonateGiftModal extends HookConsumerWidget {
  final String? storyId;
  final String? authorId;
  final AuthUser? userData;
  final Function() onAfterSendGift;
  const DonateGiftModal(
      {super.key,
      this.storyId,
      this.authorId,
      required this.onAfterSendGift,
      this.userData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.watch(globalMeProvider)?.id;
    final giftsQuery =
        useQuery(['gifts'], () => GiftRepository().fetchAllGifts());

    final userQuery = useQuery(
      ['userById', currentUserId],
      () => AuthRepository().getMyUserById(),
    );

    var lists = (giftsQuery.data ?? []);
    lists.sort((a, b) => (a.price ?? 0) - (b.price ?? 0));

    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    final selectedItem =
        useState<Gift?>(giftsQuery.data != null ? lists[0] : null);
    final sizeController = useTextEditingController(text: "1");
    final total = useState(0);

    handleTotalCoins() {
      var count = int.parse(sizeController.value.text);
      var price = selectedItem.value?.price ?? 0;
      total.value = price * count;
    }

    handleSendingGift(Gift? gift, total) async {
      var totalCoinsOfUser = userQuery.data?.wallets?[0].balance ?? 0;

      if (double.parse('${(gift?.price ?? 0) * total}') >
          double.parse(totalCoinsOfUser.toString())) {
        context.pop();
        AppSnackBar.buildTopSnackBar(
            context, 'Không đủ số dư', null, SnackBarType.info);
      } else {
        try {
          Map<String, String> body = {
            'product_id': gift?.id ?? '',
            'author_id': authorId ?? '',
          };
          for (var i = 0; i < total; i++) {
            await GiftRepository()
                .donateGift(currentUserId ?? '', storyId ?? '', body);
          }
          context.pop();
          AppSnackBar.buildTopSnackBar(
              context,
              'Tặng $total ${gift?.name} thành công',
              null,
              SnackBarType.success);
          onAfterSendGift();
          userQuery.refetch(); //refetch coins
        } catch (e) {
          // ignore: use_build_context_synchronously
          AppSnackBar.buildTopSnackBar(
              context, 'Tặng quà không thành công', null, SnackBarType.error);
        }
      }
    }

    return Flexible(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Tặng vật phẩm',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      width: size.width / 3,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: appColors.skyLightest,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                              flex: 2,
                              child: GestureDetector(
                                child: Image.asset(
                                  'assets/images/coin.png',
                                  width: 24,
                                  height: 24,
                                ),
                              )),
                          Flexible(
                              flex: 2,
                              child: Text(
                                formatNumberWithSeperator(int.tryParse(userQuery
                                    .data?.wallets?[0].balance
                                    .toStringAsFixed(0))),
                                style: textTheme.titleMedium
                                    ?.copyWith(color: appColors.inkBase),
                                textAlign: TextAlign.center,
                              )),
                          Flexible(
                            flex: 2,
                            child: TextButton(
                                onPressed: () {
                                  context.pop();
                                  // context.pushNamed('newPurchase',
                                  //     extra: {'currentUser': widget.userData});

                                  showModalBottomSheet(
                                      context: context,
                                      useSafeArea: true,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return NewPurchaseScreen(
                                          currentUser: userData,
                                        );
                                      });
                                },
                                child: Icon(
                                  Icons.add,
                                  color: appColors.inkBase,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Skeletonizer(
                enabled: giftsQuery.isFetching,
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      textDirection: TextDirection.ltr,
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      spacing: 16,
                      runSpacing: 12,
                      children: lists
                          .map((option) => GestureDetector(
                              onTap: () {
                                selectedItem.value = option;
                                handleTotalCoins();
                              },
                              child: Padding(
                                  padding: const EdgeInsets.only(right: 2),
                                  child: DonateItemCard(
                                    gift: option,
                                    selected: (selectedItem.value == option),
                                  ))))
                          .toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(total.value == 0
                          ? 'Tặng quà ngay'
                          : 'Tổng ${total.value} xu'),
                    ),
                    Flexible(
                      flex: 2,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: appColors.skyLighter),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50))),
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          int? curVal = int.tryParse(
                                                  sizeController.text) ??
                                              0;
                                          if (curVal <= 1) return;
                                          sizeController.text =
                                              (curVal - 1).toString();
                                          handleTotalCoins();
                                        },
                                        child: SvgPicture.asset(
                                          'assets/icons/remove.svg',
                                          width: 16,
                                          height: 16,
                                          color: appColors.skyBase,
                                        )),
                                    const SizedBox(width: 4),
                                    SizedBox(
                                      width: 30,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        controller: sizeController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(0),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    InkWell(
                                        onTap: () {
                                          int curVal =
                                              int.parse(sizeController.text);
                                          if (curVal >= 32) return;
                                          sizeController.text =
                                              (curVal + 1).toString();
                                          handleTotalCoins();
                                        },
                                        child: SvgPicture.asset(
                                          'assets/icons/plus.svg',
                                          width: 16,
                                          height: 16,
                                          color: appColors.primaryBase,
                                        )),
                                  ],
                                )),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            height: 40,
                            width: 85,
                            child: AppIconButton(
                              onPressed: () {
                                handleSendingGift(selectedItem?.value,
                                    int.parse(sizeController.value.text));
                              },
                              title: 'Tặng',
                              textStyle: textTheme.titleLarge
                                  ?.copyWith(color: appColors.primaryBase),
                              bgColor: appColors.primaryLightest,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ]),
      ),
    ));
  }
}
