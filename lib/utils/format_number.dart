import 'package:intl/intl.dart';

String formatNumber(int number) {
  if (number < 1000) {
    return '$number';
  } else if (number < 1000000) {
    double num = number / 1000;
    return '${num.toStringAsFixed(1)}k';
  } else {
    double num = number / 1000000;
    return '${num.toStringAsFixed(1)}m';
  }
}

String formatNumberWithSeperator(num) {
  if (num < 100) {
    return double.parse(num.toString()).toStringAsFixed(0);
  }
  var formatter = NumberFormat('#,##,000');
  return formatter.format(num);
}

int countDifference(DateTime start, DateTime end) {
  return start.difference(end).inDays;
}
