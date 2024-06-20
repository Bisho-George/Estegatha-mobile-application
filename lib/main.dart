import 'package:estegatha/features/forget-password/presentation/veiw_models/forget-password/forget_password_cubit.dart';import 'package:estegatha/features/landing/presentation/pages/landing1.dart';
import 'package:estegatha/features/landing/presentation/pages/landing_intro.dart';
import 'package:estegatha/features/landing/presentation/view_model/permissions_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/features/safty/presentation/pages/add_contact_page.dart';
import 'package:estegatha/features/safty/presentation/pages/emergency_contact_page.dart';
import 'package:estegatha/features/safty/presentation/view_models/cotact_cubit.dart';
import 'package:estegatha/features/sign-in/presentation/pages/sign_in_page.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/login_cubit/login_cubit.dart';
import 'package:estegatha/features/sos/presentation/pages/create_pin.dart';
import 'package:estegatha/features/sos/presentation/pages/send_sos.dart';
import 'package:estegatha/features/sos/presentation/view_models/cubit/create_pin_cubit.dart';
import 'package:estegatha/features/sos/presentation/view_models/cubit/send_sos_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:estegatha/routes.dart';
import 'package:get_storage/get_storage.dart';
void main() async{
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    String initialRoute = SignInPage.routeName;
    if (box.read('isFirstTime') ?? true == true) {
      initialRoute = LandingIntro.routeName;
      box.write('isFirstTime', false);
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<ForgetPasswordCubit>(
          create: (context) => ForgetPasswordCubit(),
        ),
        BlocProvider<PermissionCubit>(
          create: (context) => PermissionCubit(),
        ),
        BlocProvider<OrganizationCubit>(
          create: (context) => OrganizationCubit(),
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
        // Add more providers as needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        routes: routes,
        initialRoute: LandingIntro.routeName,
      ),
    );
  }
}
