import 'package:aklo_cafe/config/router/app_pages.dart';
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
    subscribeAdminTopic();

    _onClickMessageOpenedApp();
    _onListenting();
  }

  void subscribeAdminTopic() {
    if (GetPlatform.isWeb) return;
    _messaging.subscribeToTopic('admin');
  }

  void unSubscribeAdminTopic() {
    if (GetPlatform.isWeb) return;
    _messaging.unsubscribeFromTopic('admin');
  }

  Future<void> _initLocalNotificationSetting() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: _initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        String? id = details.payload;
        if (id != null) {
          adminRouter.go('/orders/$id');
          // adminRouter.
        }
      },
      // onDidReceiveBackgroundNotificationResponse: (details) {
      //   String? id = details.payload;
      //   if (id != null) {
      //     adminRouter.go('/orders/$id');
      //     // adminRouter.
      //   }
      // },
    );
  }

  ///Listen to firebase notification when app is on foreground
  void _onListenting() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        debugPrint('Message Data ${message.notification?.title}');

        if (message.notification != null) {
          final title = message.notification?.title;
          final body = message.notification?.body;
          final id = message.data['id'];

          await showNotification(title, body, id: id);
        }
      },
    );
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

  ///Show local notification
  Future<void> showNotification(String? title, String? body,
      {String? id}) async {
    _id++;

    NotificationDetails androidNotificationDetail = const NotificationDetails(
      android: AndroidNotificationDetails(
        'android_notification_plugin',
        'channel_name',
        playSound: true,
        importance: Importance.max,
        priority: Priority.high,
        icon: '',
        color: Color(0xff4B250F),
      ),
    );

    await _flutterLocalNotificationsPlugin.show(
      _id,
      title,
      body,
      androidNotificationDetail,
      payload: id,
    );
  }

  static void _onClickMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        debugPrint('Payload onMessageOpenedApp : ${message.data}');
        String? id = message.data['id'];
        if (id != null) {
          adminRouter.go('/orders/$id');
        }
      },
    );
  }
}
