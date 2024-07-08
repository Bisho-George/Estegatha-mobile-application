import 'package:estegatha/core/firebase/cloud_messaging.dart';
import 'package:estegatha/core/firebase/fcm_setup.dart';
import 'package:estegatha/features/home/presentation/views/home_view.dart';

import 'package:estegatha/features/sign-in/presentation/pages/sign_in_page.dart';
import 'package:estegatha/providers.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:estegatha/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toastification/toastification.dart';
import 'core/domain/handle_first_route.dart';
import 'core/firebase/notification.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  WidgetsFlutterBinding.ensureInitialized();
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
  final ValueNotifier<Widget> home = ValueNotifier<Widget>(HomeView());
  final String initialRoute = HomeView.routeName;
  @override
  void initState() {
    super.initState();
    checkUserLoggedIn(home, context);
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(firebaseMessagingForegroundHandler);
    // subscribeToMessages();
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
          builder: (_, child) => ToastificationWrapper(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Estegatha',
              // home: SignInPage(),
              home: home.value,
              routes: routes,
            ),
          ),
        );
      },
    );
  }
}
