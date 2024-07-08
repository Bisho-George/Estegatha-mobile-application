import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workmanager/workmanager.dart';

import '../../constants.dart';
import '../../features/home/domain/entities/sos_zone_entity.dart';
import '../../firebase_options.dart';
import '../firebase/fcm_setup.dart';
import '../firebase/notification.dart';
import '../work_manager/sos_zones_work_manager.dart';

class Init {

  static Future<void> initGetStorage() async {
    await GetStorage.init();
  }

  // static Future<void> initHive() async {
  //   await Hive.initFlutter();
  //   Hive.registerAdapter(SosZoneEntityAdapter());
  //   await Hive.openBox(kSosZones);
  // }

  static Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
  }

  static Future<void> initNotifications() async {
    NotificationService notificationService = NotificationService();
    await notificationService.initialize();
    FCMSetup.setupFCM((String fcmToken) {
      print('FCM Token: $fcmToken');
    });
  }

  static void initWorkManager() {
    final SosZonesWorkManager sosZonesWorkManager = SosZonesWorkManager();
    Workmanager().initialize(SosZonesWorkManager.callbackDispatcher, isInDebugMode: true);
    SosZonesWorkManager.scheduleDailyFetch();
  }
}

