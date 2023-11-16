// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   //Hanle displaying of notifications.
//   static final NotificationService _notificationService =
//       NotificationService._internal();
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   final AndroidInitializationSettings _androidInitializationSettings =
//       const AndroidInitializationSettings('ic_launcher');

//   factory NotificationService() {
//     return _notificationService;
//   }

//   NotificationService._internal() {
//     init();
//   }

//   void init() async {
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: _androidInitializationSettings,
//     );
//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   void createNotification() {
//     //show the notifications.
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'download_story',
//       'Audiory app',
//       'Đang tải truyện',
//       channelShowBadge: false,
//       importance: Importance.max,
//       priority: Priority.high,
//       onlyAlertOnce: true,
//     );
//     var platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     _flutterLocalNotificationsPlugin.show(1, 'progress notification title',
//         'progress notification body', platformChannelSpecifics,
//         payload: 'item x');
//   }
// }
