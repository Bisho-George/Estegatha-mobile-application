import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';

class HealthRecordCard extends StatelessWidget {
  final String date;
  final String chronicDisease;
  final VoidCallback onTapDeleteRecord;

  const HealthRecordCard({
    Key? key,
    required this.date,
    required this.chronicDisease,
    required this.onTapDeleteRecord,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(ConstantSizes.md),
        vertical: getProportionateScreenHeight(ConstantSizes.sm),
      ),
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(ConstantSizes.md)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ConstantSizes.md),
            child: Text(
              date,
              style: TextStyle(
                color: ConstantColors.textSecondary,
                fontSize: SizeConfig.font14,
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(ConstantSizes.xs)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ConstantSizes.md),
            child: Text(
              "Chronic disease: $chronicDisease",
              style: TextStyle(
                color: ConstantColors.primary,
                fontSize: SizeConfig.font18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(ConstantSizes.md)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ConstantSizes.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onTapDeleteRecord,
                  child: Text(
                    "Delete record",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: SizeConfig.font16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
