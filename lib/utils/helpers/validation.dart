class Validation {
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // only 11 digits are allowed
    if (value.length != 11) {
      return 'Phone number must be 11 digits';
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
      // Split the date string by '/' and rearrange it to 'MM-DD-YYYY' format
      List<String> dateParts = value.toString().split('/');
      if (dateParts.length != 3) {
        throw const FormatException('Invalid date format');
      }

      int year = int.parse(dateParts[2]);
      int month = int.parse(dateParts[0]);
      int day = int.parse(dateParts[1]);

      // Construct a DateTime object without time components
      DateTime birthday = DateTime(year, month, day);

      // Check if the entered date is not in the future
      if (birthday.isAfter(DateTime.now())) {
        return 'Birthday cannot be in the future';
      }

      print("successfully");
      // Optionally, you can add more validation rules, such as minimum age

    } on FormatException {
      return 'Please enter a valid date (MM/DD/YYYY)';
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
