import 'package:flutter/foundation.dart';

// ignore: constant_identifier_names
enum Sex { MALE, FEMALE, OTHER }

extension SexExtension on Sex {
  String get name => describeEnum(this);
  String get displayTitle {
    switch (this) {
      case Sex.FEMALE:
        return 'Nữ';
      case Sex.MALE:
        return 'Nam';
      default:
        return 'Khác';
    }
  }
}
