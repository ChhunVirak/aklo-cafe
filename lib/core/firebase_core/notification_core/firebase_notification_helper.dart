import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const _notificationIcon = 'mipmap/ic_launcher';

class NotificationHelper {
  NotificationHelper._();
  static final instance = NotificationHelper._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  ///ID for All Notification (Unique)
  int _id = 0;

  ///Android Notificaion Icon Setup
  final AndroidInitializationSettings _initializationSettingsAndroid =
      const AndroidInitializationSettings(_notificationIcon);

  void init() {
    _messaging.sendMessage();
    _requestNotificationPermission();
    _initLocalNotificationSetting();
    _onListenting();
    getDeviceToken().then(
      (value) {
        debugPrint('TOKEN => $value');
      },
    );
  }

  Future<void> _initLocalNotificationSetting() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: _initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  ///Listen to firebase notification when app is on foreground
  void _onListenting() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint('Message Data ${message.notification?.title}');

      if (message.notification != null) {
        final title = message.notification?.title;
        final body = message.notification?.body;

        await showNotification(title, body);
      }
    });
  }

  Future<NotificationSettings> _requestNotificationPermission() async {
    return await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  final NotificationDetails _androidNotificationDetail =
      const NotificationDetails(
    android: AndroidNotificationDetails(
      'android_notification_plugin',
      'channel_name',
      // playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    ),
  );

  Future<void> showNotification(
    String? title,
    String? body,
  ) async {
    await _flutterLocalNotificationsPlugin.show(
      _id++,
      title,
      body,
      _androidNotificationDetail,
      payload: 'item x',
    );
  }

  Future<String?> getDeviceToken() async => await _messaging.getToken();

  // ignore: unused_element
  void _deviceTokenChange() {
    _messaging.onTokenRefresh.listen((token) {
      ///TODO : Call function store token here
    });
  }
}
