import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
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
        height: getProportionateScreenWidth(80),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal:
                  getProportionateScreenWidth(ConstantSizes.defaultSpace)),
          child: Row(
            children: [
              Container(
                width: getProportionateScreenHeight(50),
                height: getProportionateScreenWidth(50),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ConstantColors.grey),
                ),
                child: const Icon(Icons.add, color: ConstantColors.primary),
              ),
              SizedBox(width: getProportionateScreenWidth(ConstantSizes.md)),
              Text(
                name.length > 35 ? '${name.substring(0, 35)}...' : name,
                style: TextStyle(
                  color: ConstantColors.primary,
                  fontSize: SizeConfig.font20,
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
