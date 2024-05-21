
import 'package:estegatha/features/landing/presentation/pages/landing_intro.dart';
import 'package:estegatha/features/sign-up/presentation/views/address_view.dart';
import 'package:estegatha/features/sign-up/presentation/views/email_view.dart';
import 'package:estegatha/features/sign-up/presentation/views/otp_view.dart';
import 'package:estegatha/features/sign-up/presentation/views/password_view.dart';
import 'package:estegatha/features/sos/presentation/pages/create_pin.dart';
import 'package:flutter/material.dart';

import 'features/sign-up/presentation/views/personal_info_view.dart';
import 'features/sos/presentation/pages/sos_alert_intro.dart';

final Map<String, WidgetBuilder> routes = {
  PersonalInfoView.routeName: (context) => PersonalInfoView(),
  EmailView.routeName: (context) =>  EmailView(),
  PasswordView.routeName: (context) => const PasswordView(),
  OtpView.routeName: (context) => OtpView(),
  AddressView.routeName: (context) => AddressView(),
  SosAlertIntro.routeName: (context) => SosAlertIntro(),
  CreatePin.routeName: (context) => const CreatePin(),
  LandingIntro.routeName: (context) => const LandingIntro()
};