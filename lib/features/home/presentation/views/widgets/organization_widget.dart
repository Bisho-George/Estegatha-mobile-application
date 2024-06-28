import 'package:flutter/material.dart';

import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/sizes.dart';

class OrganizationWidget extends StatelessWidget {
  const OrganizationWidget({super.key, this.isSelected = false});
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: isSelected
              ? const BorderSide(
                  color: ConstantColors.primary,
                  width: 5,
                )
              : BorderSide.none),
              color: isSelected ? ConstantColors.grey : ConstantColors.white,
        borderRadius: isSelected ? const BorderRadius.only(bottomLeft: Radius.circular(20)) : BorderRadius.zero,
        ),
      padding: const EdgeInsets.symmetric(
        horizontal: ConstantSizes.defaultSpace,
        vertical: ConstantSizes.spaceBtwItems
      ),
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: ConstantColors.primary,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Center(
                  child: Text(
                    'B',
                    style: TextStyle(
                      color: ConstantColors.white,
                      fontSize: ConstantSizes.fontSizeMd,
                      fontWeight: ConstantSizes.fontWeightSemiBold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: ConstantSizes.spaceBtwItems,
              ),
              const Text(
                'Family',
                style: TextStyle(
                  color: ConstantColors.primary,
                  fontSize: ConstantSizes.fontSizeMd,
                  fontWeight: ConstantSizes.fontWeightBold,
                ),
              ),
            ],
          ),
          if(isSelected) const Spacer(),
          if(isSelected)
            const Icon(
                Icons.check,
                size: 32,
                color: ConstantColors.primary,
              ),
        ],
      ),
    );
  }
}
