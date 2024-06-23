import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';

class OrganizationSettingItem extends StatelessWidget {
  const OrganizationSettingItem({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(ConstantSizes.md),
        vertical: getProportionateScreenHeight(ConstantSizes.md + 6),
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ConstantColors.borderSecondary,
            width: 1,
          ),
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                fontSize: SizeConfig.font18,
                fontWeight: FontWeight.w900,
                color: ConstantColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
