import 'package:audiory_v0/feat-write/widgets/paywalled_contract.dart';
import 'package:audiory_v0/models/criteria/criteria_model.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/widget_helper.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PaywalledScreen extends StatefulHookWidget {
  final Story story;
  const PaywalledScreen({super.key, required this.story});

  @override
  State<PaywalledScreen> createState() => _PaywalledScreenState();
}

class _PaywalledScreenState extends State<PaywalledScreen> {
  TextEditingController priceController = TextEditingController();
  List<TextInputFormatter> inputFormatters = [
    FilteringTextInputFormatter.digitsOnly, // Allows only digits
    LengthLimitingTextInputFormatter(2), // Limits to two digits
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      priceController.text = widget.story.isPaywalled == true
          ? "${widget.story.chapterPrice}"
          : "1";
    });
  }

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    final assessCriteriaQuery = useQuery(
      ['assessCriteria', widget.story],
      enabled: widget.story.isPaywalled == false,
      () => StoryRepostitory().assessCriteria(widget.story.id),
    );

    storyOverView() {
      return Container(
        padding: EdgeInsets.only(top: 16),
        width: size.width,
        child: Column(
          children: [
            Container(
              width: size.width / 4,
              height: size.height / 6,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: AppImage(
                width: size.width / 4,
                height: size.height / 6,
                url: widget.story.coverUrl,
              ),
            ),
            Text('${widget.story.title}', style: textTheme.titleLarge),
          ],
        ),
      );
    }

    getPaywallResult(List<Criteria> list, bool allChecked) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 4, vertical: 12),
        child: Text(
          allChecked
              ? 'Tác phẩm của bạn hiện đã đáp ứng các điệu kiện thương mại hóa'
              : 'Tác phẩm của bạn hiện chưa đáp ứng các điệu kiện thương mại hóa',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: textTheme.titleMedium?.copyWith(
              color:
                  allChecked ? appColors.primaryBase : appColors.secondaryBase),
        ),
      );
    }

    accessPaywalled(List<Criteria> list) {
      bool allChecked = list.any((e) => e.isPassed == false) ? false : true;
      return Column(
        children: [
          storyOverView(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getPaywallResult(list, allChecked),
              Container(
                height: 350,
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      Criteria? criteria = list[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: criteria?.isPassed == true
                                    ? Icon(
                                        Icons.check_circle,
                                        color: appColors.primaryBase,
                                      )
                                    : Icon(
                                        Icons.cancel,
                                        color: appColors.secondaryBase,
                                      )),
                            SizedBox(
                                width: size.width - 80,
                                child: criteria.isPassed == true
                                    ? Text(
                                        criteria.description ?? '',
                                        style: textTheme.bodyMedium,
                                      )
                                    : Text(criteria.description ?? ''))
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
          Container(
            width: size.width - 32,
            height: 50,
            child: AppIconButton(
              bgColor: allChecked ? appColors.primaryBase : appColors.inkBase,
              onPressed: () {
                allChecked
                    ? showModalBottomSheet(
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        )),
                        useSafeArea: true,
                        backgroundColor: appColors.background,
                        context: context,
                        builder: (context) {
                          return Scaffold(
                            appBar: CustomAppBar(title: Text('Hợp đồng')),
                            body: ListView(children: [
                              const PaywalledContract(),
                            ]),
                            bottomSheet: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppIconButton(
                                    isOutlined: true,
                                    onPressed: () {
                                      context.pop();
                                    },
                                    title: 'Tôi không đồng ý',
                                    textStyle: textTheme.bodySmall?.copyWith(
                                        color: appColors.primaryBase),
                                  ),
                                  AppIconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          useSafeArea: true,
                                          barrierDismissible: true,
                                          builder: (context) => AlertDialog(
                                                backgroundColor:
                                                    appColors.skyLightest,
                                                scrollable: true,
                                                title: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Tạo giá chương',
                                                        style: textTheme
                                                            .headlineSmall
                                                            ?.copyWith(
                                                                color: appColors
                                                                    ?.inkDarkest),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      TextField(
                                                        autofocus: true,
                                                        controller:
                                                            priceController,
                                                        decoration:
                                                            appInputDecoration(
                                                                    context)
                                                                .copyWith(
                                                                    hintText:
                                                                        'Nhập giá'),
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters:
                                                            inputFormatters,
                                                        textAlign:
                                                            TextAlign.center,
                                                        onChanged: (value) {
                                                          int? number =
                                                              int.tryParse(
                                                                  value);
                                                          if (number != null &&
                                                              (number < 1)) {
                                                            // Reset field if number is not in the 1-10 range
                                                            priceController
                                                                .clear();
                                                            priceController
                                                                .text = "1";
                                                          }

                                                          if (number != null &&
                                                              (number > 10)) {
                                                            // Reset field if number is not in the 1-10 range
                                                            priceController
                                                                .clear();
                                                            priceController
                                                                .text = "10";
                                                          }
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                        'Bạn có thể thay đổi giá sau này',
                                                        style: textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                                color: appColors
                                                                    ?.inkLight),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      Text(
                                                        'Giá của chương từ 1-10 xu',
                                                        style: textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                                color: appColors
                                                                    ?.inkLight),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ]),
                                                content: SizedBox(),
                                                actionsAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                actions: [
                                                  Container(
                                                    width: 100,
                                                    height: 40,
                                                    child: AppIconButton(
                                                      bgColor:
                                                          appColors.skyLightest,
                                                      color: appColors.inkBase,
                                                      title: 'Hủy',
                                                      onPressed: () {
                                                        context.pop();
                                                      },
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    height: 40,
                                                    child: AppIconButton(
                                                      title: 'Tạo',
                                                      onPressed: () async {
                                                        try {
                                                          await StoryRepostitory()
                                                              .paywallStory(
                                                                  widget
                                                                      .story.id,
                                                                  int.tryParse(
                                                                          priceController
                                                                              .text) ??
                                                                      0);

                                                          context.pop();
                                                          context.pop();
                                                          context.pop();
                                                        } catch (e) {}
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ));
                                    },
                                    textStyle: textTheme.bodySmall?.copyWith(
                                        color: appColors.skyLightest),
                                    title: 'Tôi đồng ý, tiếp tục',
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                    : context.pop();
              },
              title: allChecked ? 'Tiếp tục' : "Tôi đã hiểu",
            ),
          )
        ],
      );
    }

    paywalledStory() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Giá chương',
              style: textTheme.titleLarge,
            ),
            Text(
              'Giá của chương trong khoảng 1-10 xu',
              style: textTheme.bodySmall?.copyWith(color: appColors.inkLight),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              autofocus: false,
              controller: priceController,
              decoration:
                  appInputDecoration(context).copyWith(hintText: 'Nhập giá'),
              keyboardType: TextInputType.number,
              inputFormatters: inputFormatters,
              textAlign: TextAlign.center,
              onChanged: (value) {
                int? number = int.tryParse(value);
                if (number != null && (number < 1)) {
                  // Reset field if number is not in the 1-10 range
                  priceController.clear();
                  priceController.text = "1";
                }

                if (number != null && (number > 10)) {
                  // Reset field if number is not in the 1-10 range
                  priceController.clear();
                  priceController.text = "10";
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: AppIconButton(
                onPressed: () async {
                  try {
                    Map<String, String> body = {
                      'chapter_price':
                          '${int.tryParse(priceController.text) ?? 0}'
                    };
                    await StoryRepostitory()
                        .editStory(widget.story.id, body, ['']);
                    // ignore: use_build_context_synchronously
                    AppSnackBar.buildTopSnackBar(context,
                        'Cập nhật giá thành công', null, SnackBarType.success);
                    context.pop();
                  } catch (e) {}
                },
                title: 'Cập nhật giá chương',
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(title: Text('Thương mại hóa')),
      body: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.story.isPaywalled == false
                  ? Skeletonizer(
                      enabled: assessCriteriaQuery.data == null ||
                          assessCriteriaQuery.isFetching,
                      child: accessPaywalled(assessCriteriaQuery.data ?? []))
                  : paywalledStory()
            ]),
      ),
    );
  }
}
