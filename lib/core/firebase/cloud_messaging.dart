import 'dart:async';

import 'package:estegatha/core/domain/model/messages_types.dart';
import 'package:estegatha/features/home/presentation/view_models/home_view_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
}
subscribeToMessages(){
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    handleMessages(message, 'foreground');
  });
  FirebaseMessaging.onBackgroundMessage((message) async {
    handleMessages(message, 'background');
  });
}