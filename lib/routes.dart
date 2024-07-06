
import 'package:estegatha/features/edit_account/presentation/pages/change_email.dart';
import 'package:estegatha/features/edit_account/presentation/pages/change_password_page.dart';
import 'package:estegatha/features/edit_account/presentation/pages/change_phone_number.dart';
import 'package:estegatha/features/edit_account/presentation/pages/edit_account_menu.dart';
import 'package:estegatha/features/landing/presentation/pages/landing1.dart';
import 'package:estegatha/features/landing/presentation/pages/landing2.dart';
import 'package:estegatha/features/landing/presentation/pages/landing_intro.dart';
import 'package:estegatha/features/organization/presentation/view/create/create_organization_page.dart';
import 'package:estegatha/features/organization/presentation/view/create/invite_to_organization_page.dart';
import 'package:estegatha/features/organization/presentation/view/join/final_join_organization_page.dart';
import 'package:estegatha/features/safty/presentation/pages/add_contact_page.dart';
import 'package:estegatha/features/safty/presentation/pages/emergency_contact_page.dart';
import 'package:estegatha/features/safty/presentation/pages/location_feedback_page.dart';
import 'package:estegatha/features/sign-in/presentation/pages/sign_in_page.dart';
import 'package:estegatha/features/sign-up/presentation/views/address_view.dart';
import 'package:estegatha/features/sign-up/presentation/views/email_view.dart';
import 'package:estegatha/features/sign-up/presentation/views/otp_view.dart';
import 'package:estegatha/features/sign-up/presentation/views/password_view.dart';
import 'package:estegatha/features/sos/presentation/pages/cancel_sos.dart';
import 'package:estegatha/features/sos/presentation/pages/create_pin.dart';
import 'package:estegatha/features/sos/presentation/pages/send_sos.dart';
import 'package:estegatha/main_menu.dart';
import 'package:flutter/material.dart';

import 'features/sign-up/presentation/views/personal_info_view.dart';
import 'features/sos/presentation/pages/sos_alert_intro.dart';

final Map<String, WidgetBuilder> routes = {
  LandingIntro.routeName: (context) => const LandingIntro(),
  Landing1.routeName: (context) => const Landing1(),
  Landing2.routeName: (context) => Landing2(),
  PersonalInfoView.routeName: (context) => PersonalInfoView(),
  EmailView.routeName: (context) =>  EmailView(),
  PasswordView.routeName: (context) => const PasswordView(),
  OtpView.routeName: (context) => OtpView(),
  AddressView.routeName: (context) => AddressView(),
  SignInPage.routeName: (context) => SignInPage(),
  SosAlertIntro.routeName: (context) => SosAlertIntro(),
  CreatePin.routeName: (context) => const CreatePin(),
  EditAccountMenu.routeName: (context) => EditAccountMenu(),
  ChangeEmailPage.routeName: (context) => ChangeEmailPage(),
  ChangePassword.routeName: (context) => ChangePassword(),
  ChangePhonePage.routeName: (context) => ChangePhonePage(),
  EmergencyContactPage.routeName: (context) => EmergencyContactPage(),
  AddContactPage.routeName: (context) => AddContactPage(),
  LocationFeedbackPage.routeName: (context) => LocationFeedbackPage(),
  CreateOrganizationPage.id: (context) => const CreateOrganizationPage(),
  SendSos.routeName: (context) => const SendSos(),
  CancelSos.routeName: (context) => const CancelSos(),
  MainNavMenu.routeName: (context) => const MainNavMenu(),
  SafetyScreen.routeName: (context) => SafetyScreen(),
  HomeView.routeName: (context) => HomeView(),

};