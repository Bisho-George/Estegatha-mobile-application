
import 'package:estegatha/features/sign-up/presentation/view_models/sign_up_view_model.dart';
import 'package:estegatha/utils/common/widgets/custom_text_field.dart';
import 'package:estegatha/utils/helpers/validation.dart';
import 'package:flutter/material.dart';

class BirthdayField extends StatefulWidget {
  const BirthdayField({
    super.key,
    required this.data,
  });

  final SignUpViewModel data;

  @override
  State<BirthdayField> createState() => _BirthdayFieldState();
}

class _BirthdayFieldState extends State<BirthdayField> {
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: "Birthday",
      keyboardType: TextInputType.datetime,
      validator: (value) => Validation.validateBirthdate(value),
      hintText: "DD/MM/YYYY",
      onPressed: () {
        widget.data.selectDate(context);
      },
      suffixIcon: IconButton(
        icon: const Icon(Icons.date_range),
        onPressed: () {
          // Show date picker
          widget.data.selectDate(context);
        },
      ),
      // Use the initialized birthday controller
      controller: widget.data.birthdayController,
    );
  }
}
