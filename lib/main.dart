import 'package:estegatha/features/forget-password/presentation/veiw_models/forget-password/forget_password_cubit.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/login_cubit/login_cubit.dart';
import 'package:estegatha/routes.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'features/home/presentation/views/home_view.dart';
import 'features/landing/presentation/pages/landing_intro.dart';
import 'features/landing/presentation/view_model/permissions_cubit.dart';
import 'features/organization/presentation/view_model/organization_cubit.dart';
import 'features/safty/presentation/view_models/cotact_cubit.dart';
import 'features/sign-in/presentation/pages/sign_in_page.dart';
import 'features/sign-up/presentation/view_models/sign_up_cubit.dart';
import 'features/sign-up/presentation/views/personal_info_view.dart';
import 'features/sos/presentation/view_models/cubit/create_pin_cubit.dart';
import 'features/sos/presentation/view_models/cubit/send_sos_cubit.dart';

void main() async {
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

        BlocProvider<SignUpCubit>(create: (context) => SignUpCubit())
        // Add more providers as needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: SignInPage(),
        initialRoute: HomeView.routeName,
        routes: routes,
        theme: ThemeData(
          primaryColor: ConstantColors.primary,
        ),
      ),
    );
  }
}
