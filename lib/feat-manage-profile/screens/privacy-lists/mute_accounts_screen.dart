import 'package:audiory_v0/models/enums/Report.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/interaction_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/cards/app_avatar_image.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/report_dialog.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MuteAccountsScreen extends StatefulHookWidget {
  final String userId;
  const MuteAccountsScreen({super.key, required this.userId});

  @override
  State<MuteAccountsScreen> createState() => _MuteAccountsScreenState();
}

class _MuteAccountsScreenState extends State<MuteAccountsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final muteAccountsQuery = useQuery(
        ['myMutedAccounts'], () => InteractionRepository().getMutedAccounts());

    handleUnmute({accountId}) async {
      context.pop();
      try {
        final res = await InteractionRepository().unmute(accountId);

        // ignore: use_build_context_synchronously

        muteAccountsQuery.refetch();
      } catch (e) {}
    }

    return Scaffold(
      appBar: CustomAppBar(
          title: Text(
        'Danh sách ngừng tương tác',
        style: textTheme.headlineSmall,
        textAlign: TextAlign.center,
      )),
      body: RefreshIndicator(
        onRefresh: () async {
          muteAccountsQuery.refetch();
        },
        child: Container(
          height: size.height,
          child: Skeletonizer(
            enabled: muteAccountsQuery.isFetching,
            child: ListView.builder(
                itemCount: muteAccountsQuery.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  var account = muteAccountsQuery.data?[index];
                  if (muteAccountsQuery.data?.isEmpty ?? false) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              'Bạn đang không dừng tương tác với ai cả.',
                              style: textTheme.titleMedium
                                  ?.copyWith(color: appColors.inkBase),
                            ),
                          ),
                          Text(
                            'Khi bạn dừng tương tác với một ai đó, bạn sẽ không còn nhận được bất kỳ tin nhắn, bình luận truyện hoặc bình luận bài đăng, kể cả xem trang cá nhân của họ',
                            style: textTheme.bodySmall
                                ?.copyWith(color: appColors.inkLight),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                flex: 1,
                                child: AppAvatarImage(
                                  size: 40,
                                  url: account?.avatarUrl,
                                )),
                            Flexible(
                                flex: 4,
                                child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      account?.fullName ?? 'Người dùng',
                                      style: textTheme.titleMedium,
                                    ))),
                            Flexible(
                              child: PopupMenuButton(
                                  position: PopupMenuPosition.under,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                  child: Container(
                                      margin: const EdgeInsets.only(right: 16),
                                      child: Icon(Icons.more_horiz,
                                          color: appColors.inkDarker)),
                                  onSelected: (value) {
                                    if (value == 0) {
                                      QuickAlert.show(
                                        onCancelBtnTap: () {
                                          context.pop();
                                        },
                                        onConfirmBtnTap: () {
                                          handleUnmute(accountId: account?.id);
                                        },
                                        context: context,
                                        type: QuickAlertType.confirm,
                                        title:
                                            'Tương tác với người dùng ${account?.fullName == '' ? 'này' : account?.fullName}?',
                                        text:
                                            'Tài khoản này hiện có thể theo dõi, gửi tin nhắn, đăng bình luận trên hồ sơ của bạn và bình luận trong truyện của bạn',
                                        textColor: appColors.inkLight,
                                        titleAlignment: TextAlign.center,
                                        confirmBtnText: 'Xác nhận',
                                        cancelBtnText: 'Hủy',
                                        confirmBtnColor: appColors.inkBase,
                                        confirmBtnTextStyle:
                                            textTheme.bodyMedium?.copyWith(
                                                color: appColors.skyLightest),
                                        cancelBtnTextStyle: textTheme.bodyMedium
                                            ?.copyWith(
                                                color: appColors.inkLight),
                                      );
                                    }
                                    if (value == 1) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return ReportDialog(
                                                reportType:
                                                    ReportType.USER.name,
                                                reportId: account?.id ?? '');
                                          });
                                    }
                                  },
                                  itemBuilder: (context) => [
                                        PopupMenuItem(
                                            height: 36,
                                            value: 0,
                                            child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(Icons.volume_up_outlined,
                                                      size: 18,
                                                      color:
                                                          appColors.inkLighter),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    'Tương tác với ${account?.fullName}',
                                                    style:
                                                        textTheme.titleMedium,
                                                  )
                                                ])),
                                        PopupMenuItem(
                                            height: 36,
                                            value: 1,
                                            child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(Icons.flag_outlined,
                                                      size: 18,
                                                      color: appColors
                                                          .secondaryBase),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    'Báo cáo người dùng',
                                                    style: textTheme.titleMedium
                                                        ?.copyWith(
                                                            color: appColors
                                                                .secondaryBase),
                                                  )
                                                ])),
                                      ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
