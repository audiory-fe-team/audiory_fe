import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/feat-manage-profile/screens/privacy-lists/detail_report_screen.dart';
import 'package:audiory_v0/models/enums/Report.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/report/report_model.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/repositories/interaction_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_date.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/cards/app_avatar_image.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReportsScreen extends StatefulHookWidget {
  final String userId;
  const ReportsScreen({super.key, required this.userId});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final reportsQuery = useQuery(['myReports'],
        () => AuthRepository().getMyReports(userId: widget.userId));

    handleUnmute({reportId}) async {
      context.pop();
      try {
        final res = await InteractionRepository().unmute(reportId);

        // ignore: use_build_context_synchronously
        reportsQuery.refetch();
      } catch (e) {}
    }

    handleCreateReport(reportId) async {
      context.pop();

      Map<String, String> body = <String, String>{};

      body['description'] = _formKey.currentState?.fields['description']?.value;
      body['title'] = _formKey.currentState?.fields['title']?.value;
      body['reported_id'] = reportId;
      body['report_type'] = 'USER';
      body['user_id'] = widget.userId;

      print(body);
      try {
        final res = await InteractionRepository()
            .report(body, _formKey.currentState!.fields['photo']?.value);

        // ignore: use_build_context_synchronously
        AppSnackBar.buildTopSnackBar(
            context, 'Tạo báo cáo thành công', null, SnackBarType.success);
        print(res);
        reportsQuery.refetch();
      } catch (e) {
        print(e);
      }
    }

    getReportTitle(context, Report? report) {
      String reportText = ReportType.values
          .byName(report?.reportedType ?? 'COMMENT')
          .displayText;

      String title = 'Bạn đã $reportText';

      return title;
    }

    Map<String, dynamic> getReportStatus(context, Report? report) {
      final AppColors appColors = Theme.of(context).extension<AppColors>()!;

      Map<String, dynamic> map = {
        'status': 'Đang xử lý',
        'color': appColors.skyLight,
      };
      if (report?.reportStatus == 'APPROVED') {
        map.update('status', (value) => 'Đã phê duyệt');
        map.update('color', (value) => appColors.primaryLightest);
      } else if (report?.reportStatus == 'REJECTED') {
        map.update('status', (value) => 'Đã từ chối');
        map.update('color', (value) => appColors.secondaryLighter);
      }
      return map;
    }

    return Scaffold(
      appBar: CustomAppBar(
          title: Text(
        'Lịch sử báo cáo',
        style: textTheme.headlineSmall,
        textAlign: TextAlign.center,
      )),
      body: RefreshIndicator(
        onRefresh: () async {
          reportsQuery.refetch();
        },
        child: Skeletonizer(
          enabled: reportsQuery.isFetching,
          child: Container(
            height: size.height,
            child: Skeletonizer(
              enabled: reportsQuery.isFetching,
              child: ListView.builder(
                  itemCount: reportsQuery.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    var report = reportsQuery.data?[index];
                    if (reportsQuery.data?.isEmpty ?? false) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 24, horizontal: 16),
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
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            useSafeArea: true,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return DetailReportScreen(
                                report: report,
                              );
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    flex: 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: appColors.skyLight,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: AppImage(
                                          width: 50,
                                          height: 50,
                                          url: report?.imageUrl == ''
                                              ? FALLBACK_REPORT_URL
                                              : report?.imageUrl,
                                        ),
                                      ),
                                    )),
                                Flexible(
                                    flex: 5,
                                    child: Container(
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              getReportTitle(context, report),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: textTheme.titleMedium
                                                  ?.copyWith(
                                                      color: appColors.inkDark),
                                            ),
                                            Text(
                                              report?.description ?? 'Nội dung',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.justify,
                                              style: textTheme.bodySmall
                                                  ?.copyWith(
                                                      color: appColors.inkBase),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              appFormatDate(
                                                  report?.createdDate),
                                              style: textTheme.bodySmall
                                                  ?.copyWith(
                                                      color: appColors.inkBase),
                                            )
                                          ],
                                        ))),
                                Flexible(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsetsDirectional.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: getReportStatus(
                                              context, report)['color']),
                                      child: Text(
                                        getReportStatus(
                                            context, report)['status'],
                                        style: textTheme.bodySmall?.copyWith(
                                            color: appColors.inkBase,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
