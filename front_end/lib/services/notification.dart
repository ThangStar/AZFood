import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService();

  static Future<void> showNoti(
    int id,
    FlutterLocalNotificationsPlugin fln,
  ) async {
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(
            defaultActionName: 'Open notification');
    var androidInit = const AndroidInitializationSettings("mipmap/chicken");
    var darwinInitialization = const DarwinInitializationSettings();
    var initSetting = InitializationSettings(
        android: androidInit,
        iOS: darwinInitialization,
        linux: initializationSettingsLinux);
    fln.initialize(
      initSetting,
      onDidReceiveNotificationResponse: (details) {
        // onDidReceiveNotificationResponse(details);
      },
    );

    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "CHANNEL_ID",
      "CHANEL NAME",
      importance: Importance.high,
      playSound: true,
      priority: Priority.high,
      actions: [
        AndroidNotificationAction("ID_MESSAGE", "Trả lời",
            cancelNotification: true,
            inputs: [AndroidNotificationActionInput(label: "Nhập tin nhắn..")],
            showsUserInterface: true,
            titleColor: Colors.amber,
            allowGeneratedReplies: true)
      ],
    );
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(badgeNumber: 1);
    var noti = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await fln.show(id, "Em yêu ❤", "Anh đang làm gì thế?", noti);
  }
}

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    debugPrint('notification payload: ${payload.toString()}');
    debugPrint('notification ID: ${notificationResponse.id}');
    debugPrint('notification Action ID: ${notificationResponse.actionId}');

    if (notificationResponse.input?.isNotEmpty ?? false) {
      print(
          'notification action tapped with input: ${notificationResponse.input}');
    }
  }
}
