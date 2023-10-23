import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum TransactionType {
  // ignore: constant_identifier_names
  PURCHASE,
  // ignore: constant_identifier_names
  WITHDRAW,
  // ignore: constant_identifier_names
  REFUND,
  // ignore: constant_identifier_names
  GIFT_SENT,
  // ignore: constant_identifier_names
  CHAPTER_BOUGHT,
  // ignore: constant_identifier_names
  REWARD_FROM_GIFT,
  // ignore: constant_identifier_names
  REWARD_FROM_STORY,
  // ignore: constant_identifier_names
  DAILY_REWARD,
}

extension TransactionTypeExtension on TransactionType {
  String get name => describeEnum(this);

  IconData get displayIcon {
    switch (this) {
      case TransactionType.PURCHASE:
        return Icons.credit_card;
      case TransactionType.WITHDRAW:
        return Icons.info_outline;
      case TransactionType.CHAPTER_BOUGHT:
        return Icons.shopping_bag_outlined;
      case TransactionType.DAILY_REWARD:
        return Icons.card_giftcard;
      default:
        return Icons.check_circle_outline_rounded;
    }
  }

  Color get displayBgColor {
    switch (this) {
      case TransactionType.PURCHASE:
        return const Color(0xFF439A97);
      case TransactionType.WITHDRAW:
        return const Color(0xFF303437);
      case TransactionType.CHAPTER_BOUGHT:
        return Colors.redAccent;
      case TransactionType.DAILY_REWARD:
        return Colors.cyan[300] as Color;
      default:
        return Color.fromARGB(255, 123, 150, 149);
    }
  }

  String get displayText {
    switch (this) {
      case TransactionType.PURCHASE:
        return 'Nạp thành công vào ví';
      case TransactionType.WITHDRAW:
        return 'Rút thành công';
      case TransactionType.CHAPTER_BOUGHT:
        return 'Mua chương';
      case TransactionType.DAILY_REWARD:
        return 'Nhận thưởng hàng ngày';
      default:
        return 'Giao dịch khác';
    }
  }

  Color get displayIconColor {
    switch (this) {
      case TransactionType.PURCHASE:
        return const Color(0xFF439A97);
      case TransactionType.WITHDRAW:
        return const Color(0xFF090A0A);
      case TransactionType.CHAPTER_BOUGHT:
        return const Color(0xFF090A0A);
      case TransactionType.DAILY_REWARD:
        return const Color(0xFF090A0A);
      default:
        return const Color(0xFF439A97);
    }
  }

  String get displayTrend {
    switch (this) {
      case TransactionType.WITHDRAW:
        return '-';
      case TransactionType.CHAPTER_BOUGHT:
        return '-';
      default:
        return '+';
    }
  }
}
