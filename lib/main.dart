import 'package:estegatha/features/forget-password/presentation/veiw_models/forget-password/forget_password_cubit.dart';
import 'package:estegatha/features/landing/presentation/pages/landing1.dart';
import 'package:estegatha/features/landing/presentation/pages/landing2.dart';
import 'package:estegatha/features/sign-in/presentation/pages/sign_in_page.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/login_cubit/login_cubit.dart';
import 'package:estegatha/features/sign-up/cubit/date_picker/date_picker_cubit.dart';
import 'package:estegatha/features/sos/presentation/pages/cancel_sos_pin.dart';
import 'package:estegatha/features/sos/presentation/pages/create_pin.dart';
import 'package:estegatha/features/sos/presentation/pages/send_sos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/landing/presentation/pages/landing_intro.dart';
import 'features/sos/presentation/pages/cancel_sos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<ForgetPasswordCubit>(
          create: (context) => ForgetPasswordCubit(),
        ),
        // Add more providers as needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: CancelSosPin(),
      ),
    );
  }
}
