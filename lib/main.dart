import 'dart:convert';

import 'package:estegatha/features/forget-password/presentation/veiw_models/forget-password/forget_password_cubit.dart';
import 'package:estegatha/features/organization/domain/models/member.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/features/sign-in/presentation/pages/sign_in_page.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/login_cubit/login_cubit.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:estegatha/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:estegatha/features/landing/presentation/pages/landing_intro.dart';
import 'package:estegatha/features/edit_account/presentation/view_models/edit_account_cubit.dart';
import 'package:estegatha/features/landing/presentation/view_model/permissions_cubit.dart';
import 'package:estegatha/features/safty/presentation/view_models/cotact_cubit.dart';
import 'package:estegatha/features/sos/presentation/view_models/cubit/create_pin_cubit.dart';
import 'package:estegatha/features/sos/presentation/view_models/cubit/send_sos_cubit.dart';
import 'package:estegatha/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() {
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<ForgetPasswordCubit>(
          create: (context) => ForgetPasswordCubit(),
        ),
        BlocProvider<OrganizationCubit>(
          create: (context) => OrganizationCubit(),
        ),
        BlocProvider<PermissionCubit>(
          create: (context) => PermissionCubit(),
        ),
        BlocProvider<CreatePinCubit>(
          create: (context) => CreatePinCubit(),
        ),
        BlocProvider<SendSosCubit>(
          create: (context) => SendSosCubit(),
        ),
        BlocProvider<ContactCubit>(
          create: (context) => ContactCubit(),
        ),
        BlocProvider<EditAccountCubit>(
          create: (context) => EditAccountCubit(),
        ),
      ],
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
  final ValueNotifier<bool> isUserLoggedIn = ValueNotifier<bool>(false);
  String initialRoute = SignInPage.routeName;
  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
  }

  Future<void> checkUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson != null) {
      print("User object from shared preferences => $userJson");
      final user = Member.fromJson(jsonDecode(userJson));
      BlocProvider.of<UserCubit>(context).setUser(user);
      isUserLoggedIn.value = true;
      initialRoute = MainNavMenu.routeName;
    }else{
      checkFirstTime();
    }
  }
  void checkFirstTime() {
    final box = GetStorage();
    if (box.read('isFirstTime') ?? true == true) {
      initialRoute = LandingIntro.routeName;
      box.write('isFirstTime', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isUserLoggedIn,
      builder: (context, isLoggedIn, child) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            routes: routes,
            initialRoute: initialRoute,
          ),
        );
      },
    );
  }
}
