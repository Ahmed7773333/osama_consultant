// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:osama_consul/core/network/firebase_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzz;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/HomeLayout/data/models/message.dart';

class NotificationService {
  late SharedPreferences pref;
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    pref = await SharedPreferences.getInstance();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tzz.initializeTimeZones();
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
}
