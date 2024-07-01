import 'package:intl_phone_field/phone_number.dart';

class Validation {

  static String? validatePhone(PhoneNumber? value) {
    if (value == null || value.number.isEmpty) {
      return 'Phone number is required';
    }
    try {
      if (!value.isValidNumber()) {
        return 'Please enter a valid number';
      }
    } catch (e) {
      return 'Invalid phone number format';
    }
    // Add more validation logic here
    return null;
  }


  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // valid regex for email
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Invalid email';
    }

    // Add email validation logic here
    return null;
  }

  static String? validateDefaultFields(String? fieldType, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldType is required';
    }
    return null;
  }


  static String? validateBirthdate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your birthday';
    }

    // Check if the entered value is in a valid date format
    try {
      // Split the date string by '/' and rearrange it to 'DD/MM/YYYY' format
      List<String> dateParts = value.split('/');
      if (dateParts.length != 3) {
        throw const FormatException('Invalid date format');
      }

      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);

      // Construct a DateTime object without time components
      DateTime birthday = DateTime(year, month, day);
      print(birthday);
      print(DateTime.now());

      // Check if the entered date is not in the future
      if (birthday.isAfter(DateTime.now())) {
        return 'Birthday cannot be in the future';
      }
      // Optionally, you can add more validation rules, such as minimum age

    } on FormatException {
      return 'Please enter a valid date (DD/MM/YYYY)';
    }

    return null; // Return null if validation passes
  }




  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // at least 6 characters
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    // Add any additional password validation logic here
    return null;
  }

  // confirm password validation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }

    // check if the password matches the confirm password
    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }
}
