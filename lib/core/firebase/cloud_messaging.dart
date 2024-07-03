import 'dart:async';

import 'package:dio/dio.dart';
import 'package:estegatha/constants.dart';
import 'package:estegatha/core/data/api/dio_auth.dart';
import 'package:estegatha/core/domain/model/messages_types.dart';
import 'package:estegatha/core/firebase/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

handleMessages(RemoteMessage message, String appState) {
  switch (message.data['type']) {
    case MessageTypes.INIT_SOS:
      break;
    case MessageTypes.CANCEL_SOS:
      break;
    case MessageTypes.CANCEL_HEALTH_ISSUE:
      break;
    case MessageTypes.CHANGE_ROLE:
      break;
    case MessageTypes.CREATE_BOUNDARY:
      break;
    case MessageTypes.CREATE_POST:
      break;
    case MessageTypes.INIT_HEALTH_ISSUE:
      break;
    case MessageTypes.JOIN_BOUNDARY:
      break;
    case MessageTypes.JOIN_ORG:
      break;
    case MessageTypes.LEAVE_BOUNDARY:
      break;
    case MessageTypes.LEAVE_ORG:
      break;
    case MessageTypes.MODIFY_POST:
      break;
    case MessageTypes.REMOVE_BOUNDARY:
      break;
    case MessageTypes.REMOVE_MEMBER:
      break;
  }
  NotificationService notificationService = NotificationService();
  notificationService.showNotification(
      message.notification!.title!, message.notification!.body!);
}

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  // Your background message handling logic here
  print("Handling a background message: ${message.messageId}");
}

subscribeToMessages() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    handleMessages(message, 'foreground');
  });
  // FirebaseMessaging.onBackgroundMessage((message) async {
  //   handleMessages(message, 'background');
  // });
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
}

joinToOrganizationNotification(int orgId) async {
  print("=====================================");
  print("joinToOrganizationNotification...");
  print("=====================================");
  Dio dio = await DioAuth.getDio();
  String? token = await FirebaseMessaging.instance.getToken();
  print("Token for Notification: $token");
  if (token != null) {
    dio.post('$baseUrl$joinNotificationEndPoint', queryParameters: {
      'organizationId': orgId.toString(), // organization id to join
      'token': token,
    });

    print("========Organization detail to join========");
    print("Organization ID: $orgId");
  }
}

Future<void> sendNotification({
  required String subject,
  required String content,
  required String type,
  required Map<String, dynamic> customData,
  required Map<String, dynamic>? parameters,
}) async {
  try {
    Dio dio = await DioAuth.getDio();

    final response = await dio.post(baseUrl + notifyMembersEndPoint,
        data: {
          'subject': subject,
          'content': content,
          'type': type,
          'data': customData,
        },
        // 'organizationId': organizationId.toString(),
        queryParameters: parameters);

    print("Notification sent successfully: ${response.data}");
  } catch (e) {
    print("Error sending notification: $e");
  }
}
