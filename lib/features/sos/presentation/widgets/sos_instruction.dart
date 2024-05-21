import 'package:flutter/material.dart';

import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/sizes.dart';



class SosInstruction extends StatelessWidget {
  final String instruction;
  const SosInstruction({
    super.key,
    required this.instruction
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.check),
        const SizedBox(width: ConstantSizes.spaceBtwItems),
        Text(
          instruction,
          style: const TextStyle(
              fontSize: ConstantSizes.md,
              fontWeight: ConstantSizes.fontWeightRegular,
              color: ConstantColors.textPrimary
          ),
        ),
      ],
    );
  }
}
