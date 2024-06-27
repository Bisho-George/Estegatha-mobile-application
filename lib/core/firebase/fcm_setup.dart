
import 'package:estegatha/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
class FCMSetup{
  static Future<String?> setupFCM(void Function (String fcmToken)onTokenRefresh) async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      FirebaseMessaging.instance.onTokenRefresh.listen(onTokenRefresh);
      GetStorage box = GetStorage();
      box.write(fcmTokenKey, token);
    }
    return token;
  }
  static requestPermission()async{
    await FirebaseMessaging.instance.requestPermission(
        provisional: true
    );
  }
}