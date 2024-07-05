import 'dart:convert';

import 'package:estegatha/core/firebase/SosScreen.dart';
import 'package:estegatha/core/firebase/fcm_setup.dart';
import 'package:estegatha/features/home/presentation/views/home_view.dart';
import 'package:estegatha/features/organization/domain/models/member.dart';
import 'package:estegatha/features/sign-in/presentation/pages/sign_in_page.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:estegatha/features/sign-up/presentation/views/personal_info_view.dart';
import 'package:estegatha/main_menu.dart';
import 'package:estegatha/providers.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:estegatha/utils/helpers/simple_bloc_observer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:estegatha/features/landing/presentation/pages/landing_intro.dart';
import 'package:estegatha/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/firebase/notification.dart';
import 'firebase_options.dart';

void main() async {
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  Bloc.observer = SimpleBlocObserver();
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
    checkUserLoggedIn();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      var user = await HelperFunctions.getUser();
      if (message.notification != null &&
          message.data['userId'] != user.id.toString()) {
        NotificationService notificationService = NotificationService();
        notificationService.showNotification(
            message.notification!.title!, message.notification!.body!);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SosScreen(message: message)));
    });
    // FirebaseMessaging.onBackgroundMessage((message) async {
    //   var user = await HelperFunctions.getUser();
    //   if (message.data['userId'] != user.id.toString()) {
    //     NotificationService notificationService = NotificationService();
    //     notificationService.showNotification(
    //         message.notification!.title!, message.notification!.body!);
    //   }
    // });
  }

  Future<void> checkUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson != null) {
      print("User object from shared preferences => $userJson");
      final user = Member.fromJson(jsonDecode(userJson));
      BlocProvider.of<UserCubit>(context).setUser(user);
      home.value = MainNavMenu();
      // home.value = SendSos();
    } else {
      checkFirstTime();
    }
  }

  void checkFirstTime() {
    final box = GetStorage();
    if (box.read('isFirstTime') ?? true == true) {
      home.value = const LandingIntro();
      box.write('isFirstTime', false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
