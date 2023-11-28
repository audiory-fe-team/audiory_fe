import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/models/report/report_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class DetailReportScreen extends StatefulWidget {
  final Report? report;
  const DetailReportScreen({super.key, this.report});

  @override
  State<DetailReportScreen> createState() => _DetailReportScreenState();
}

class _DetailReportScreenState extends State<DetailReportScreen> {
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    Report? report = widget.report;
    return Scaffold(
      appBar: CustomAppBar(
          title: Text(
        'Chi tiết báo cáo',
        style: textTheme.titleLarge,
      )),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          report?.title ?? '',
                          style: textTheme.titleMedium,
                          textAlign: TextAlign.justify,
                        ),
                        Text(
                          report?.description ?? '',
                          style: textTheme.bodyMedium
                              ?.copyWith(color: appColors.inkBase),
                          textAlign: TextAlign.justify,
                        )
                      ],
                    )),
                Flexible(
                    child: Container(
                  decoration: BoxDecoration(color: appColors.skyLightest),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AppImage(
                      width: size.width * 0.3,
                      height: size.width * 0.4,
                      url: report?.imageUrl != ""
                          ? report?.imageUrl
                          : FALLBACK_REPORT_URL,
                    ),
                  ),
                )),
              ],
            ),
          ),
          Text('Chúng tôi đã nhận được báo cáo của bạn')
        ],
      )),
    );
  }
}
