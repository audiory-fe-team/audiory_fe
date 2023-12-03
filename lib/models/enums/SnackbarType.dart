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
        return Color.fromARGB(255, 226, 170, 168);
      case SnackBarType.info:
        return Color.fromARGB(255, 194, 193, 193);
      case SnackBarType.warning:
        return Color.fromARGB(255, 231, 209, 141);
      default:
        return Color.fromARGB(255, 192, 223, 222);
    }
  }

  Color get displayTextColor {
    switch (this) {
      case SnackBarType.error:
        return const Color(0xFF404446);
      case SnackBarType.info:
        return const Color(0xFF404446);
      case SnackBarType.warning:
        return const Color(0xFF404446);
      default:
        return const Color(0xFF404446);
    }
  }
}
