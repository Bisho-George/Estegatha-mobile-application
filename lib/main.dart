import 'dart:convert';

import 'package:estegatha/core/firebase/cloud_messaging.dart';
import 'package:estegatha/core/firebase/fcm_setup.dart';
import 'package:estegatha/features/sign-in/presentation/pages/sign_in_page.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:estegatha/features/sos/presentation/pages/send_sos.dart';
import 'package:estegatha/main_menu.dart';
import 'package:estegatha/providers.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:estegatha/features/landing/presentation/pages/landing_intro.dart';
import 'package:estegatha/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/domain/handle_first_route.dart';
import 'core/firebase/notification.dart';
import 'features/home/presentation/views/home_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  NotificationService notificationService = NotificationService();
  await notificationService.initialize();
  FCMSetup.setupFCM((String fcmToken) {
    print('FCM Token: $fcmToken');
  });
  runApp(
    MultiBlocProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  final ValueNotifier<Widget> home = ValueNotifier<Widget>(SignInPage());
  final String initialRoute = SignInPage.routeName;
  @override
  void initState() {
    super.initState();
    checkUserLoggedIn(home, context);
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    subscribeToMessages();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ValueListenableBuilder<Widget>(
      valueListenable: home,
      builder: (context, isLoggedIn, child) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Estegatha',
            home: home.value,
            routes: routes,
          ),
        );
      },
    );
  }
}
