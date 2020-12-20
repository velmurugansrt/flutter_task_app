import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const id = 'poc_my_id';
const name = 'poc_my_name';
const description = 'poc_my_description';
const ticker = 'ticker';
const app_icon = 'app_icon';

class PushNotification {
  PushNotification._();
  static PushNotification _this;
  factory PushNotification() {
    if (_this == null) _this = PushNotification._();
    return _this;
  }
  StreamController notificationDoneController = StreamController.broadcast();
  Stream get fetchNotification => notificationDoneController.stream;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void initLocalNotification() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(app_icon);
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (data) async {
      onSelectNotification(data);
    });
  }

  Future<void> showLocalNotification(Map message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      id,
      name,
      description,
      importance: Importance.max,
      playSound: true,
      icon: app_icon,
      priority: Priority.high,
      ticker: ticker,
    );
    IOSNotificationDetails iOSPlatformChannelSpecifics =
        const IOSNotificationDetails();
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    final String title = message['notification']['title'];
    final String body = message['notification']['body'];
    final String payload = json.encode(message['data']);
    flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload);
  }

  Future<dynamic> onSelectNotification(String payload) async {
    if (payload != null) {
      Map data = json.decode(payload);
      data['localNotification'] = true;
      eventTrigger(data);
    }
    return false;
  }

  void eventTrigger(data) {
    notificationDoneController.add(data);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {
    // print('onDidReceiveLocalNotification $payload');
    // if (payload != null) {
    //   var data = json.decode(payload);
    //   data['localNotification'] = true;
    //   eventTrigger(data);
    // }
  }
}
