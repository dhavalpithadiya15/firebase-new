import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () async {
          FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
          await firebaseMessaging.requestPermission();
        },
        child: const Text(""),
      ),
    );
  }
}


