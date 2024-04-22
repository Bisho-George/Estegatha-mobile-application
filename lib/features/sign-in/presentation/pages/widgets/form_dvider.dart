import "package:estegatha/utils/constant/colors.dart";
import "package:flutter/material.dart";

class FormDivider extends StatelessWidget {
  const FormDivider({
    super.key,
    required this.dividerText,
  });

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          child: Divider(
            color: ConstantColors.grey,
            thickness: 0.5,
            indent: 15,
            endIndent: 5,
          ),
        ),
        Text((dividerText),
            style: const TextStyle(color: ConstantColors.darkGrey)),
        const Flexible(
          child: Divider(
            color: ConstantColors.grey,
            thickness: 0.5,
            indent: 5,
            endIndent: 15,
          ),
        )
      ],
    );
  }
}
