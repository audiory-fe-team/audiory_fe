String formatRelativeTime(String dateString) {
  DateTime now = DateTime.now().toUtc();
  DateTime date = DateTime.parse(dateString);

  Duration difference = now.difference(date);

  if (difference.inDays > 30) {
    int months = (difference.inDays / 30).floor();
    return '$months ${months == 1 ? 'month' : 'months'} ago';
  } else if (difference.inDays >= 1) {
    int days = difference.inDays;
    return '$days ${days == 1 ? 'day' : 'days'} ago';
  } else if (difference.inHours >= 1) {
    int hours = difference.inHours;
    return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
  } else if (difference.inMinutes >= 1) {
    int minutes = difference.inMinutes;
    return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
  } else {
    return 'Just now';
  }
}
