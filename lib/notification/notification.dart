import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationHandler {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final androidChannel =
      const AndroidNotificationDetails("Test Id", "Test Name", channelDescription: "This is for testing");

  Future<void> initNotification() async {
    final String? fmcToken = await firebaseMessaging.getToken();
    print("Device FMC Token => $fmcToken");
    AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings('app_icon');
    InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((event) {
      RemoteNotification? remoteNotification = event.notification;
      if (remoteNotification != null) {
        print("NOTIFICATION TITTLE => ${remoteNotification.title}");
        print("NOTIFICATION BODY => ${remoteNotification.body}");
        flutterLocalNotificationsPlugin.show(
          remoteNotification.hashCode,
          remoteNotification.title,
          remoteNotification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(androidChannel.channelId, androidChannel.channelName,
                channelDescription: androidChannel.channelDescription,
                importance: Importance.max,
                priority: Priority.max),
          ),
        );
      } else {
        print("REMOTE NOTIFICATION NULL");
      }
    });
  }

  Future<void> showTimeZoneNotification(int id, String tittle, String description, String dateTime) async {
    flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      tittle,
      description,
      tz.TZDateTime.now(tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails("Test", "My Test"),
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
