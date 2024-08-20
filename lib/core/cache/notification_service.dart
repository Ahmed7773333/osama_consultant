// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:osama_consul/core/api/api_manager.dart';
import 'package:osama_consul/core/api/end_points.dart';
import 'package:osama_consul/core/cache/shared_prefrence.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzz;
import '../../my_app.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    return token;
  }

  Future<void> pushNotification(String title, String body, String? email,
      {int? id}) async {
    try {
      await ApiManager().postDataa(
        EndPoints.sendNotification,
        data: {'Authorization': 'Bearer ${await UserPreferences.getToken()}'},
        body: id == null
            ? {'title': title, 'body': body, 'email': email}
            : {'title': title, 'body': body, 'id': id},
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> init() async {
    debugPrint(await UserPreferences.getFcmToken());
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {
          // Navigate to the appropriate screen based on payload
          Navigator.of(MyApp.navigatorKey.currentContext!).pushNamed(
            response.payload!,
          );
        }
      },
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
      body.split('/').first,
      platformChannelSpecifics,
    );
  }
}
