import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

class PushNotificationService {
  Future<void> setUpFirebase() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    firebaseCloudMessagingListeners();
  }

   firebaseCloudMessagingListeners() {
     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
       print('A new onMessage event was published!');
       RemoteNotification? notification = message.notification;
       AndroidNotification? android = message.notification?.android;
       if (notification != null && android != null) {
         flutterLocalNotificationsPlugin.show(
             notification.hashCode,
             notification.title,
             notification.body,
             NotificationDetails(
               android: AndroidNotificationDetails(
                 channel.id,
                 channel.name,
                 channel.description,
                 color: Colors.green,
                 playSound: true,
                 icon: '@mipmap/icon',
               ),
             ));
       }
     });

     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
       print('A new onMessageOpenedApp event was published!');
       RemoteNotification? notification = message.notification;
       AndroidNotification? android = message.notification?.android;

     });
   }
   }