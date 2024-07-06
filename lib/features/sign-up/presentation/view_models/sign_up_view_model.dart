import 'package:estegatha/features/sign-up/presentation/view_models/date_picker_view_model.dart';
import 'package:estegatha/features/sign-up/presentation/view_models/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/personal_info_entity.dart';

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
  final TextEditingController addressController = TextEditingController();
  final List<TextEditingController> otpControllers = List.generate(6, (_) => TextEditingController());
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

  void validateForm(BuildContext context, String routeName, ) {
    if (personalInfoFormKey.currentState!.validate()) {
      // Parse the birthdayController.text to DateTime
      DateTime? birthday = datePickerViewModel.parseDate(birthdayController.text);
      PersonalInfoEntity personalInfo = PersonalInfoEntity(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        birthDate: birthday,
        phoneNumber: phoneController.text,
      );
      BlocProvider.of<SignUpCubit>(context).updatePersonalInfo(personalInfo);

      // Navigate to the email page
      Navigator.pushNamed(context, routeName);
    }
  }
}