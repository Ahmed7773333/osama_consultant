// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:osama_consul/config/app_routes.dart';
import 'package:osama_consul/core/network/firebase_helper.dart';
// import 'package:osama_consul/features/admin/Home%20Layout%20Admin/data/models/chat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzz;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/user/HomeLayout/data/models/message.dart';
import '../../my_app.dart';

class NotificationService {
  late SharedPreferences pref;
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    pref = await SharedPreferences.getInstance();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveBackgroundNotificationResponse: (payload) async {
      //   if (pref.getString('name') != null) {
      //     Navigator.of(MyApp.navigatorKey.currentContext!)
      //         .pushNamed(Routes.chatScreenAdmin, arguments: {
      //       'id': ChatModel(
      //           chatName: pref.getString('name') ?? '',
      //           chatOwner: pref.getString('email') ?? ''),
      //       'isadmin': false
      //     });
      //   }
      // },
    );
    tzz.initializeTimeZones();

    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        showNotification(
          notification.hashCode,
          notification.title ?? '',
          notification.body ?? '',
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('A new onMessageOpenedApp event was published!');
      Navigator.of(MyApp.navigatorKey.currentContext!).pushNamed(
        message.data['route'],
      );
    });
  }

  Future<void> zonedScheduleNotification(
    int id,
    String title,
    String body,
    DateTime scheduledDate,
  ) async {
    final tz.TZDateTime tzDateTime =
        tz.TZDateTime.from(scheduledDate, tz.local);
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzDateTime,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> showNotification(int id, String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  void listenToFirestoreChanges(id) {
    FirebaseFirestore.instance
        .collection(FirebaseHelper.chatCollection)
        .doc(id)
        .collection(FirebaseHelper.messagesCollection)
        .orderBy(FirebaseHelper.time, descending: false)
        .snapshots()
        .listen((snapshot) {
      if ((pref.getInt('lengthOfMessages') ?? 0) < snapshot.docs.length &&
          MessageModel.fromDocument(snapshot.docs.last).senderId != id) {
        MessageModel messageData =
            MessageModel.fromDocument(snapshot.docs.last);
        showNotification(
          0,
          messageData.senderId,
          messageData.text ?? '',
        );
        pref.setInt('lengthOfMessages', snapshot.docs.length);
      }
    });
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    debugPrint("Handling a background message: ${message.messageId}");
    // Handle background message logic here if needed
  }
}
