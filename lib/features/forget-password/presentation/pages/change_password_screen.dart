import 'package:estegatha/features/forget-password/presentation/veiw_models/forget-password/forget_password_cubit.dart';
import 'package:estegatha/utils/common/widgets/custom_text_field.dart';
import 'package:estegatha/utils/helpers/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// class ChangePasswordPage extends StatefulWidget {
//   final String token;

//   ChangePasswordPage({required this.token});

//   @override
//   _ChangePasswordPageState createState() => _ChangePasswordPageState();
// }

// class _ChangePasswordPageState extends State<ChangePasswordPage> {
//   final GlobalKey<FormState> formKey = GlobalKey();
//   String? email;
//   String? newPassword;

//   @override
//   Widget build(BuildContext context) {
//     print("Token from change password screen: ${widget.token}");
//     return Scaffold(
//       backgroundColor: Colors.grey[500],
//       appBar: AppBar(
//         title: Text('Change Password'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Text('Change Password'),
//         // child: Form(
//         //   key: formKey,
//         //   child: Column(
//         //     children: [
//         //       CustomTextField(
//         //         labelText: "Email",
//         //         onChanged: (value) {
//         //           email = value;
//         //         },
//         //         prefixIcon: const Icon(Icons.email),
//         //         validator: (value) => Validation.validateEmail(value),
//         //       ),
//         //       CustomTextField(
//         //         labelText: "New Password",
//         //         onChanged: (value) {
//         //           newPassword = value;
//         //         },
//         //         prefixIcon: const Icon(Icons.lock),
//         //         validator: (value) => Validation.validatePassword(value),
//         //       ),
//         //       ElevatedButton(
//         //         onPressed: () {
//         //           print("Change password submit button pressed");
//         //           if (formKey.currentState!.validate()) {
//         //             BlocProvider.of<ForgetPasswordCubit>(context)
//         //                 .changePassword(
//         //                     email: email!,
//         //                     newPassword: newPassword!,
//         //                     token: widget.token);
//         //           }
//         //         },
//         //         child: Text('Change Password'),
//         //       ),
//         //     ],
//         //   ),
//         // ),
//       ),
//     );
//   }
// }

class ChangePasswordPage extends StatefulWidget {
  final String token;

  ChangePasswordPage({required this.token});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    print("Token from change password screen: ${widget.token}");
    return Scaffold(
      backgroundColor: Colors.grey[600], // Temporary background color
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Center(
        child: Text('Token: ${widget.token}', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
