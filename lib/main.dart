import 'package:estegatha/core/firebase/cloud_messaging.dart';
import 'package:estegatha/core/init/init.dart';
import 'package:estegatha/features/home/presentation/views/home_view.dart';
import 'package:estegatha/providers.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:estegatha/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'constants.dart';
import 'core/domain/handle_first_route.dart';
import 'features/home/domain/entities/sos_zone_entity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Init.initGetStorage();
  // await Init.initHive();
  await Hive.initFlutter();
  Hive.registerAdapter(SosZoneEntityAdapter());
  await Hive.openBox(kSosZones);
  await Init.initFirebase();
  await Init.initNotifications();
  Init.initWorkManager();

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
