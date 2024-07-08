import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.labelText,
    this.formKey,
    this.focusNode,
    this.isPrimary = true,
    this.isLoading = false,
    this.textSize
  });
  final bool isLoading;

  final GlobalKey<FormState>? formKey;
  final void Function()? onPressed;
  final String labelText;
  final double? textSize;
  FocusNode? focusNode;
  final bool isPrimary;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
          padding: EdgeInsets.symmetric(
              vertical:
                  getProportionateScreenHeight(ConstantSizes.buttonHeight)),
          textStyle: TextStyle(
              fontSize: textSize ?? SizeConfig.font20,
              color: ConstantColors.textWhite,
              fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  getProportionateScreenHeight(ConstantSizes.buttonRadius))),
        ),
        onPressed: onPressed,
        child: isLoading
            ? const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )
            : Text(labelText),
      ),
    );
  }
}