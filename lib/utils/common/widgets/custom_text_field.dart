import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onPressed;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final int? maxLines;

  const CustomTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.validator,
    this.obscureText = false,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.onPressed,
    this.textAlign,
    this.inputFormatters,
    this.initialValue,
    this.maxLines = 1,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText!,
      controller: widget.controller,
      onTap: widget.onPressed,
      onChanged: widget.onChanged,
      textAlign: widget.textAlign ?? TextAlign.left,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        prefixIconColor: ConstantColors.darkGrey,
        suffixIconColor: ConstantColors.darkGrey,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        hintText: widget.hintText,
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
          borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
          borderSide:
              const BorderSide(width: 1, color: ConstantColors.textInputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
          borderSide:
              const BorderSide(width: 1, color: ConstantColors.textInputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
          borderSide:
              const BorderSide(width: 1, color: ConstantColors.borderPrimary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
          borderSide: const BorderSide(width: 1, color: ConstantColors.warning),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
          borderSide: const BorderSide(width: 2, color: ConstantColors.warning),
        ),
      ),
    );
  }
}
