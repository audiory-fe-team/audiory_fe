import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ReportType {
  // ignore: constant_identifier_names
  USER,
  // ignore: constant_identifier_names
  STORY,
  // ignore: constant_identifier_names
  COMMENT,
  // ignore: constant_identifier_names
  REVENUE_COMPLAINT,
  // ignore: constant_identifier_names
  CONTENT_VIOLATION_COMPLAINT,
}

extension ReportTypeExtension on ReportType {
  String get name => describeEnum(this);

  IconData get displayIcon {
    switch (this) {
      case ReportType.USER:
        return Icons.attach_money_sharp;
      case ReportType.STORY:
        return Icons.keyboard_return_outlined;
      case ReportType.CONTENT_VIOLATION_COMPLAINT:
        return Icons.shopping_bag_outlined;
      default:
        return Icons.check_circle_outline_rounded;
    }
  }

  Color get displayBgColor {
    switch (this) {
      default:
        return Color.fromARGB(0, 237, 235, 235);
    }
  }

  String get displayText {
    switch (this) {
      case ReportType.USER:
        return 'Báo cáo người dùng';
      case ReportType.STORY:
        return 'Báo cáo truyện';
      case ReportType.COMMENT:
        return 'Báo cáo bình luận';
      case ReportType.REVENUE_COMPLAINT:
        return 'Báo cáo doanh thu';
      case ReportType.CONTENT_VIOLATION_COMPLAINT:
        return 'Kháng cáo nội dung';
      default:
        return 'Báo cáo khác';
    }
  }

  Color get displayIconColor {
    switch (this) {
      case ReportType.USER:
        return const Color(0xFF439A97);
      case ReportType.STORY:
        return const Color(0xFF090A0A);
      default:
        return const Color(0xFF439A97);
    }
  }

  String get displayTrend {
    switch (this) {
      case ReportType.STORY:
        return '-';
      case ReportType.CONTENT_VIOLATION_COMPLAINT:
        return '-';
      case ReportType.REVENUE_COMPLAINT:
        return '-';
      default:
        return '+';
    }
  }

  bool get isCoin {
    switch (this) {
      case ReportType.STORY:
        return false;
      default:
        return true;
    }
  }
}
