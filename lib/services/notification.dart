import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';

class SendNotification {
  SendNotification._();

// this function is for getting the payload when notification is tapped and app opens
  static Future<void> checkForNotifications() async {
    // get the notification details
    NotificationAppLaunchDetails? details =
        await notificationsPlugin.getNotificationAppLaunchDetails();

    // get the response if the details is not null
    if (details != null) {
      if (details.didNotificationLaunchApp) {
        NotificationResponse? response = details.notificationResponse;
        if (response != null) {
          // get the payload
          String? payload = response.payload;
          log('Payload: $payload');
        }
      }
    }
  }

  static void showSimpleNotifications({required int otp}) async {

    log('Simple Notification got clicked');
    // Note: Before making notifications, its details need to be defined for both ios and android
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId', // channel id can be anything
      'channelName', // channel name can be anything,
      priority: Priority.max,
      importance: Importance.max,
      enableLights: true,
      enableVibration: true,
    );

    DarwinNotificationDetails iosNotificationDetail =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentBanner: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetail,
    );

    // show the notification
    await notificationsPlugin.show(
        123, // Note thid id must be dynamic, but for demo static int is used
        'OTP code', // title
        'Your otp code is: $otp', // body
        notificationDetails,

        // Note: add payload
        payload: 'payload data Sanjiv Shrestha');
  }
}
