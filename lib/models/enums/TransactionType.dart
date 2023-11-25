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
        return Icons.attach_money_sharp;
      case TransactionType.WITHDRAW:
        return Icons.keyboard_return_outlined;
      case TransactionType.CHAPTER_BOUGHT:
        return Icons.shopping_bag_outlined;
      case TransactionType.DAILY_REWARD:
        return Icons.card_giftcard_sharp;
      case TransactionType.REWARD_FROM_STORY:
        return Icons.diamond_outlined;
      case TransactionType.REWARD_FROM_GIFT:
        return Icons.card_giftcard_sharp;
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
      case TransactionType.PURCHASE:
        return 'Nạp thành công vào ví';
      case TransactionType.WITHDRAW:
        return 'Rút thành công';
      case TransactionType.REFUND:
        return 'Hoàn tiền thành công';
      case TransactionType.GIFT_SENT:
        return 'Tặng quà thành công';
      case TransactionType.CHAPTER_BOUGHT:
        return 'Mua chương';
      case TransactionType.DAILY_REWARD:
        return 'Nhận thưởng hàng ngày';
      case TransactionType.REWARD_FROM_GIFT:
        return 'Nhận quà từ người đọc';
      case TransactionType.REWARD_FROM_STORY:
        return 'Nhận thưởng từ tác phẩm';
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
      case TransactionType.REWARD_FROM_GIFT:
        return const Color(0xFF090A0A);
      case TransactionType.REWARD_FROM_STORY:
        return const Color(0xFF090A0A);
      case TransactionType.CHAPTER_BOUGHT:
        return Color.fromARGB(255, 10, 10, 9);
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
      case TransactionType.GIFT_SENT:
        return '-';
      default:
        return '+';
    }
  }

  bool get isCoin {
    switch (this) {
      case TransactionType.REWARD_FROM_GIFT:
        return false;
      case TransactionType.REWARD_FROM_STORY:
        return false;
      case TransactionType.WITHDRAW:
        return false;
      default:
        return true;
    }
  }
}
