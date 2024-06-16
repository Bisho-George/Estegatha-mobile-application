
import 'package:estegatha/features/home/presentation/views/home_view.dart';
import 'package:estegatha/features/sign-in/presentation/pages/sign_in_page.dart';
import 'package:estegatha/features/sign-up/presentation/views/address_view.dart';
import 'package:estegatha/features/sign-up/presentation/views/email_view.dart';
import 'package:estegatha/features/sign-up/presentation/views/otp_view.dart';
import 'package:estegatha/features/sign-up/presentation/views/password_view.dart';
import 'package:estegatha/features/sos_alert/presentation/views/sos_alert_intro.dart';
import 'package:flutter/material.dart';

import 'features/sign-up/presentation/views/personal_info_view.dart';


final Map<String, WidgetBuilder> routes = {
  SignInPage.routeName: (context) => SignInPage(),
  PersonalInfoView.routeName: (context) => PersonalInfoView(),
  EmailView.routeName: (context) =>  EmailView(),
  PasswordView.routeName: (context) => const PasswordView(),
  OtpView.routeName: (context) => OtpView(),
  AddressView.routeName: (context) => AddressView(),
  SosAlertIntro.routeName: (context) => SosAlertIntro(),
  HomeView.routeName: (context) =>  HomeView(),



};