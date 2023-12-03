import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/models/report/report_model.dart';
import 'package:audiory_v0/repositories/report_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DetailReportScreen extends HookWidget {
  final String reportId;

  const DetailReportScreen({super.key, required this.reportId});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final reportQuery = useQuery(
      ['report', reportId],
      () => ReportRepository.fetchReportById(reportId),
      refetchOnMount: RefetchOnMount.stale,
      staleDuration: const Duration(minutes: 5),
    );

    if (reportQuery.isError) {
      return Scaffold(
        appBar: CustomAppBar(
            title: Text(
          'Chi tiết báo cáo',
          style: textTheme.titleLarge,
        )),
        body: Text(
          'Có lỗi xảy ra, thử lại sau',
          style: textTheme.titleLarge,
        ),
      );
    }

    return Scaffold(
        appBar: CustomAppBar(
            title: Text(
          'Chi tiết báo cáo',
          style: textTheme.titleLarge,
        )),
        body: Skeletonizer(
          enabled: reportQuery.isFetching,
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tiêu đề:',
                              style: textTheme.titleMedium,
                              textAlign: TextAlign.justify,
                            ),
                            Text(
                              reportQuery.data?.title ?? '',
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: appColors.inkBase),
                              textAlign: TextAlign.justify,
                            ),
                            Text(
                              'Nội dung:',
                              style: textTheme.titleMedium,
                              textAlign: TextAlign.justify,
                            ),
                            Text(
                              reportQuery.data?.description ?? '',
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: appColors.inkBase),
                              textAlign: TextAlign.justify,
                            )
                          ],
                        )),
                    const SizedBox(height: 12),
                    Flexible(
                        child: Container(
                      decoration: BoxDecoration(
                        color: appColors.skyLightest,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: AppImage(
                            width: size.width * 0.3,
                            height: size.width * 0.4,
                            url: reportQuery.data?.imageUrl),
                      ),
                    )),
                  ],
                ),
              ),
              (reportQuery.data?.approvedBy == null &&
                      reportQuery.data?.rejectedBy == null)
                  ? Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: appColors.skyLightest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('Chúng tôi đã nhận được báo cáo của bạn'))
                  : Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: reportQuery.data?.approvedBy != null
                            ? appColors.primaryLightest
                            : appColors.secondaryLightest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(reportQuery.data?.approvedBy != null
                          ? 'Báo cáo đã được chấp nhận'
                          : 'Báo cáo đã bị từ chối')),
            ],
          )),
        ));
  }
}
