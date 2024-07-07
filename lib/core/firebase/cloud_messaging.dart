import 'dart:async';

import 'package:dio/dio.dart';
import 'package:estegatha/constants.dart';
import 'package:estegatha/core/data/api/dio_auth.dart';
import 'package:estegatha/core/domain/model/messages_types.dart';
import 'package:estegatha/core/firebase/notification.dart';
import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
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
      exitOrganizationNotification(message.data['organizationId']);
      break;
  }

  if (appState == 'foreground') {
    print(
        " ===========> The app is already opened, no need to show notification... <===========");
  } else {
    print("Message received in background: ${message.notification!.title}");
  }
  NotificationService notificationService = NotificationService();
  notificationService.showNotification(
      message.notification!.title!, message.notification!.body!);
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("================Enter onBackgroundMessage================");
  handleMessages(message, 'background');
}

Future<void> firebaseMessagingForegroundHandler(RemoteMessage message) async {
  print("================Enter foreground listen================");
  handleMessages(message, 'foreground');
}

subscribeToMessages() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    handleMessages(message, 'foreground');
  });
}

Future<void> joinToOrganizationNotification(int orgId) async {
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

Future<void> joinNotificationSystem(List<Organization> organizations) async {
  for (var organization in organizations) {
    await joinToOrganizationNotification(organization.id!);
  }
}

Future<void> sendNotification({
  required String subject,
  required String content,
  required String type,
  required Map<String, dynamic> customData,
  Map<String, dynamic>? parameters,
  required int userId,
}) async {
  try {
    Dio dio = await DioAuth.getDio();

    // if userId is equal to the current user id, then don't send notification
    if (userId == UserCubit().getCurrentUser()?.id) {
      return;
    }

    final response = await dio.post(baseUrl + notifyMembersEndPoint,
        data: {
          'subject': subject,
          'content': content,
          'type': type,
          'data': customData,
        },
        queryParameters: parameters);

    print("Notification sent successfully: ${response.data}");
  } catch (e) {
    print("Error sending notification: $e");
  }
}

Future<void> exitOrganizationNotification(int orgId) async {
  print("=====================================");
  print("exit OrganizationNotification...");
  print("=====================================");
  Dio dio = await DioAuth.getDio();
  String? token = await FirebaseMessaging.instance.getToken();
  print("Token for Notification: $token");
  if (token != null) {
    dio.post('$baseUrl$exitNotificationEndPoint', queryParameters: {
      'organizationId': orgId.toString(),
      'token': token,
    });
  }

  print("========Organization with id $orgId exit successfully========");
}

Future<void> exitNotificationSystem(List<Organization> organizations) async {
  for (var organization in organizations) {
    await exitOrganizationNotification(organization.id!);
  }
}
