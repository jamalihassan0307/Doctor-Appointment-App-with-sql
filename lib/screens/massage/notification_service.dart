// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: (String? id) async {
      //   print("onSelectNotification");
      //   if (id!.isNotEmpty) {
      //     print("Router Value1234 $id");

      //     // Navigator.of(context).push(
      //     //   MaterialPageRoute(
      //     //     builder: (context) => DemoScreen(
      //     //       id: id,
      //     //     ),
      //     //   ),
      //     // );

      //   }
      // },
    );
  }

  // static void createAndDisplayCallNotification(RemoteMessage message) async {
  //   try {
  //     final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  //     AwesomeNotifications().createNotification(
  //       content: NotificationContent(
  //           id: id,
  //           channelKey: 'basic_channel',
  //           title: message.notification!.title,
  //           body: message.notification!.body),
  //       actionButtons: <NotificationActionButton>[
  //         NotificationActionButton(key: 'yes', label: 'Yes'),
  //         NotificationActionButton(key: 'no', label: 'No'),
  //       ],
  //     );
  //   } on Exception catch (e) {
  //     print(e);
  //   }
  // }

  static void createAndDisplayChatNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            "pushnotificationapp", "pushnotificationappchannel",
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher'),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
