import 'package:aklo_cafe/module/auth/controller/auth_controller.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

const _notificationIcon = '@drawable/ic_notification';

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
    _requestNotificationPermission();
    _initLocalNotificationSetting();
    _deviceTokenChange();
    _subscribeAdminTopic();
    getDeviceToken().then((value) {
      debugPrint('Token : $value');
      // Get.put<AuthController>(AuthController()).storeDeviceToken(value);
    });
    _onListenting();
  }

  void _subscribeAdminTopic() {
    if (GetPlatform.isWeb) return;
    _messaging.subscribeToTopic('admin');
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

  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  Future<AndroidDeviceInfo> get android async =>
      await _deviceInfoPlugin.androidInfo;

  ///Show local notification
  Future<void> showNotification(
    String? title,
    String? body, {
    Color? color,
  }) async {
    _id++;

    NotificationDetails androidNotificationDetail = const NotificationDetails(
      android: AndroidNotificationDetails(
          'android_notification_plugin', 'channel_name',
          playSound: true,
          importance: Importance.max,
          priority: Priority.high,
          icon: '',
          color: Color(0xff4B250F)),
    );

    await _flutterLocalNotificationsPlugin.show(
      _id,
      title,
      body,
      androidNotificationDetail,
      payload: 'order_detail',
    );
  }

  Future<String?> getDeviceToken() async => await _messaging.getToken();

  ///device token can refresh
  void _deviceTokenChange() {
    _messaging.onTokenRefresh.listen(
      (token) {
        Get.find<AuthController>().storeDeviceToken(token);
      },
    );
  }
}
