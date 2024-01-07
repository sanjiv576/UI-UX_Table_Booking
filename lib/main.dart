import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart';
import 'app.dart';

// making a global notification variable throughout the app
FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  // initialize timezone for schedule notifications
  initializeTimeZones();

// for android
  AndroidInitializationSettings androidSettings =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  // for ios
  DarwinInitializationSettings iosSettings =
      const DarwinInitializationSettings();

  // combining of both ios and android initializations
  InitializationSettings initializationSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );

  // initiliaze the notifications

  bool? initializedNotification =
      await notificationsPlugin.initialize(initializationSettings,
          // triggers this when the app is opened from the notification
          onDidReceiveNotificationResponse: (response) {
    log('Payload after tapping notification when app is off : ${response.payload}');
  });

  log("Notifications value : $initializedNotification");

  runApp(const ProviderScope(child: App()));
}
