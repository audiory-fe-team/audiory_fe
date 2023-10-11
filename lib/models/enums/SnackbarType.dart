import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning, info }

extension SnackBarTypeExtension on SnackBarType {
  String get name => describeEnum(this);

  IconData get displayIcon {
    switch (this) {
      case SnackBarType.error:
        return Icons.error_outline_rounded;
      case SnackBarType.info:
        return Icons.info_outline;
      case SnackBarType.warning:
        return Icons.warning_amber_outlined;
      default:
        return Icons.check_circle_outline_rounded;
    }
  }

  Color get displayBgColor {
    switch (this) {
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.info:
        return const Color(0xFF303437);
      case SnackBarType.warning:
        return Colors.amber;
      default:
        return const Color(0xFF439A97);
    }
  }

  Color get displayTextColor {
    switch (this) {
      case SnackBarType.error:
        return Colors.white;
      case SnackBarType.info:
        return Colors.white;
      case SnackBarType.warning:
        return const Color(0xFF090A0A);
      default:
        return Colors.white;
    }
  }
}
