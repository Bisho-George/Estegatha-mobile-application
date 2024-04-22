import 'package:estegatha/features/forget-password/presentation/veiw_models/forget-password/forget_password_cubit.dart';
import 'package:estegatha/features/sign-in/presentation/pages/sing_in_page.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        title: 'Flutter Demo',
        home: SignInPage(),
      ),
    );
  }
}
