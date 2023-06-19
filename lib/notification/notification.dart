import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final androidChannel = const AndroidNotificationDetails("Test Id", "Test Name", channelDescription: "This is for testing");

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
            android: AndroidNotificationDetails(
              androidChannel.channelId,
              androidChannel.channelName,
              channelDescription: androidChannel.channelDescription,
            ),
          ),
        );
      } else {
        print("REMOTE NOTIFICATION NULL");
      }
    });
  }
}
