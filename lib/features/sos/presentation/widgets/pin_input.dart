import 'package:estegatha/features/sos/presentation/widgets/pin_field.dart';
import 'package:flutter/material.dart';
class PinInput extends StatelessWidget {
  const PinInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PinField(),
        PinField(),
        PinField(),
        PinField(),
      ],
    );
  }
}
