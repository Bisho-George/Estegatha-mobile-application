import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

class SuggestionItem extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const SuggestionItem({required this.name, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ConstantColors.white,
          boxShadow: [
            BoxShadow(
              color: ConstantColors.darkGrey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        width: double.infinity,
        height: 80,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: ConstantSizes.defaultSpace),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ConstantColors.grey),
                ),
                child: const Icon(Icons.add, color: ConstantColors.primary),
              ),
              const SizedBox(width: ConstantSizes.md),
              Text(
                name,
                style: const TextStyle(
                  color: ConstantColors.primary,
                  fontSize: ConstantSizes.fontSizeLg,
                  fontWeight: ConstantSizes.fontWeightBold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
