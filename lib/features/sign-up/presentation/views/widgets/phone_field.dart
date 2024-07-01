import 'package:estegatha/features/sign-up/presentation/view_models/sign_up_view_model.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/validation.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.data,
  });

  final SignUpViewModel data;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: InputDecoration(
        prefixIconColor: ConstantColors.darkGrey,
        suffixIconColor: ConstantColors.darkGrey,
        labelText: "Phone Number",
        labelStyle: const TextStyle(
          fontSize: ConstantSizes.fontSizeMd,
          color: ConstantColors.darkGrey,
        ),
        hintStyle: const TextStyle(
          fontSize: ConstantSizes.fontSizeMd,
          color: ConstantColors.darkGrey,
        ),
        errorStyle: const TextStyle(
          fontStyle: FontStyle.normal,
        ),
        floatingLabelStyle: TextStyle(
          color: ConstantColors.primary.withOpacity(0.8),
        ),
        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(ConstantSizes.inputFieldRadius),
          borderSide: const BorderSide(
              width: 1, color: ConstantColors.textInputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(ConstantSizes.inputFieldRadius),
          borderSide: const BorderSide(
              width: 1, color: ConstantColors.textInputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(ConstantSizes.inputFieldRadius),
          borderSide: const BorderSide(
            width: 1,
            color: ConstantColors.borderPrimary,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(ConstantSizes.inputFieldRadius),
          borderSide: const BorderSide(
            width: 1,
            color: ConstantColors.warning,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(ConstantSizes.inputFieldRadius),
          borderSide: const BorderSide(
            width: 2,
            color: ConstantColors.warning,
          ),
        ),
      ),
      initialCountryCode: 'EG',
      validator: (val) => Validation.validatePhone(val),
      controller: data.phoneController,
    );
  }
}