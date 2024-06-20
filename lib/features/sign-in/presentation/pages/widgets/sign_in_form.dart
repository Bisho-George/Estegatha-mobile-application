import 'package:estegatha/features/forget-password/presentation/pages/forget_password_page.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/login_cubit/login_cubit.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/common/widgets/custom_text_field.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInForm extends StatefulWidget {
  SignInForm({super.key, required this.signInWithPhone});

  final bool signInWithPhone;

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> formKey = GlobalKey();

  String? password, phone, email;
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: ConstantSizes.defaultSpace),
        child: Column(
          children: [
            if (widget.signInWithPhone)
              CustomTextField(
                labelText: "Phone Number",
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  phone = value;
                },
                validator: (value) => Validation.validatePhone(value),
                prefixIcon: const Icon(Icons.phone),
              )
            else
              CustomTextField(
                labelText: "Email",
                onChanged: (value) {
                  email = value;
                },
                validator: (value) => Validation.validateEmail(value),
                prefixIcon: const Icon(Icons.email),
              ),
            const SizedBox(
              height: ConstantSizes.spaceBtwInputFields,
            ),
            CustomTextField(
              labelText: "Password",
              onChanged: (value) {
                password = value;
              },
              validator: (value) => Validation.validatePassword(value),
              obscureText: _obscureText,
              prefixIcon: const Icon(Icons.password),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
            const SizedBox(
              height: ConstantSizes.spaceBtwInputFields,
            ),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                labelText: "Login",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (widget.signInWithPhone == true) {
                      BlocProvider.of<LoginCubit>(context).loginWithPhone(
                        phone: phone!,
                        password: password!,
                      );
                    } else {
                      BlocProvider.of<LoginCubit>(context).loginWithEmail(
                        email: email!,
                        password: password!,
                      );
                    }
                  }
                },
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ForgetPasswordPage();
                    }));
                  },
                  child: const Text('Forget your password?'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
