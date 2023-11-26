import 'package:intl/intl.dart';

String appFormatDate(String? date) {
  //use package intl
  print(date);
  if (date != null && date != "") {
    DateTime dateTime = DateTime.parse(date);
    final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputFormat.parse(date));
  } else {
    return '';
  }
}

String appFormatDateWithHHmm(String? date) {
  //use package intl

  if (date != null && date != "") {
    DateTime dateTime = DateTime.parse(date);
    final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final outputFormat = DateFormat('dd/MM/yyyy - HH:mm');
    return outputFormat.format(inputFormat.parse(date));
  } else {
    return '';
  }
}
