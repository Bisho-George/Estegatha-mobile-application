import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.labelText,
    this.formKey,
    this.focusNode,
    this.isPrimary = true,
  });

  final GlobalKey<FormState>? formKey;
  final void Function()? onPressed;
  final String labelText;
  FocusNode? focusNode;
  final bool isPrimary;

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
          disabledBackgroundColor: ConstantColors.grey,
          // side: const BorderSide(color: ConstantColors.primary),
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
