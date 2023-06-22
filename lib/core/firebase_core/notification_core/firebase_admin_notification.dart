// ignore_for_file: constant_identifier_names, unused_element

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
  Future<void> sentNotification({
    required title,
    required String body,
    required String id,
  }) async {
    const priority = 'high';
    try {
      Response res = await post(
        _BASE_URL,
        {
          "priority": priority,
          "data": {
            "id": id,
          },
          "notification": {
            "title": title,
            "body": body,
          },
          "to": "/topics/admin"
        },
        headers: _headers,
      );
      debugPrint('Status Code : ${res.statusCode}');
    } catch (_) {
      debugPrint('Something Went Wrong : $_');
    }
  }
}
