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
