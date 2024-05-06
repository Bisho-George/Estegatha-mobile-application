import 'package:estegatha/features/sign-up/presentation/view_models/date_picker_view_model.dart';
import 'package:flutter/material.dart';

class SignUpViewModel {
  final GlobalKey<FormState> _personalInfoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _addressFormKey = GlobalKey<FormState>();


  GlobalKey<FormState> get addressFormKey => _addressFormKey;

  GlobalKey<FormState> get emailFormKey => _emailFormKey;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  DatePickerViewModel datePickerViewModel = DatePickerViewModel();
  final GlobalKey<FormState> formKey = GlobalKey();

  String? password, phone, email;
  bool obscureText = true;

  void togglePasswordVisibility() {
    obscureText = !obscureText;
  }

  // Getter for accessing the form key
  GlobalKey<FormState> get personalInfoFormKey => _personalInfoFormKey;

  GlobalKey<FormState> get passwordFormKey => _passwordFormKey;

  GlobalKey<FormState> get otpFormKey => _otpFormKey;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    // Update birthdayController if a date is selected
    if (pickedDate != null) {
      // Extract day, month, and year
      final day = pickedDate.day.toString().padLeft(2, '0');
      final month = pickedDate.month.toString().padLeft(2, '0');
      final year = pickedDate.year.toString();

      // Concatenate into the desired format
      final formattedDate = '$day/$month/$year';

      // Set the formatted date to the birthdayController
      birthdayController.text = formattedDate;
    }
  }
}
