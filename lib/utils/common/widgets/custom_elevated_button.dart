import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.labelText,
    this.formKey,
  });

  final GlobalKey<FormState>? formKey;
  final void Function() onPressed;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: ConstantColors.light,
          backgroundColor: ConstantColors.primary,
          disabledForegroundColor: ConstantColors.darkGrey,
          disabledBackgroundColor: ConstantColors.buttonDisabled,
          side: const BorderSide(color: ConstantColors.primary),
          padding:
              const EdgeInsets.symmetric(vertical: ConstantSizes.buttonHeight),
          textStyle: const TextStyle(
              fontSize: ConstantSizes.fontSizeMd,
              color: ConstantColors.textWhite,
              fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ConstantSizes.buttonRadius)),
        ),
        onPressed: onPressed,
        child: Text(labelText),
      ),
    );
  }
}
