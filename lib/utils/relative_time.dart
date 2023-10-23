String formatRelativeTime(String? dateString) {
  if (dateString == null || dateString == '') return '';
  DateTime now = DateTime.now().toUtc();
  DateTime date = DateTime.parse(dateString);

  Duration difference = now.difference(date);

  if (difference.inDays > 30) {
    int months = (difference.inDays / 30).floor();
    return '$months tháng trước';
  } else if (difference.inDays >= 1) {
    int days = difference.inDays;
    return '$days ngày trước';
  } else if (difference.inHours >= 1) {
    int hours = difference.inHours;
    return '$hours giờ trước';
  } else if (difference.inMinutes >= 1) {
    int minutes = difference.inMinutes;
    return '$minutes phút trước';
  } else {
    return 'Vừa xong';
  }
}
