import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/landing/presentation/pages/landing_intro.dart';
import '../../features/organization/domain/models/member.dart';
import '../../features/sign-in/presentation/veiw_models/user_cubit.dart';
import '../../main_menu.dart';

Future<void> checkUserLoggedIn(ValueNotifier<Widget> home, BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final userJson = prefs.getString('user');

  if (userJson != null) {
    print("User object from shared preferences => $userJson");
    final user = Member.fromJson(jsonDecode(userJson));
    BlocProvider.of<UserCubit>(context).setUser(user);
    home.value = const MainNavMenu();
    //home.value = SignInPage();
  } else {
    final box = GetStorage();
    if (box.read('isFirstTime') ?? true == true) {
      home.value = const LandingIntro();
      box.write('isFirstTime', false);
    }
  }
}