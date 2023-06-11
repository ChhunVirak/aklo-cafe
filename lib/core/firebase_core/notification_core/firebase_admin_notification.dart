// ignore_for_file: constant_identifier_names, unused_element

import 'package:aklo_cafe/module/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const _SERVER_TOKEN =
    'AAAATFHm4fY:APA91bHw4LShO3RwLbSwjsfQdh7RCnGou_acwnZz4gYgVpKTEwD_TwrIeCQYph1HmmlFeyCm4I_fDKOUQcdg88sDYWm-pe8Ekxci_uHE7uF2sW1fAKs6FwWs--u8MwU_mFLkh04kQL_Z';
const _BASE_URL = 'https://fcm.googleapis.com/fcm/send';

class AdminNotificationManager extends GetConnect {
  AdminNotificationManager._();

  static final instance = AdminNotificationManager._();

  final _headers = {
    "Content-Type": "application/json",
    "Authorization": "key=$_SERVER_TOKEN",
  };

  ///Sent Notification To Client
  Future<void> sentNotification(String title, String body) async {
    final deviceToken = await Get.find<AuthController>().getDeviceToken();
    debugPrint('TOKEN : $deviceToken');
    const priority = 'high';
    try {
      Response res = await post(
        _BASE_URL,
        {
          "priority": priority,
          "data": {
            "title": title,
            "body": body,
          },
          "notification": {
            "title": title,
            "body": body,
          },
          "to": deviceToken
        },
        headers: _headers,
      );
      debugPrint('Status Code : ${res.statusCode}');
    } catch (_) {
      debugPrint('Something Went Wrong : $_');
    }
  }
}
