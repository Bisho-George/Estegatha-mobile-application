import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';

class OrganizationMemberCard extends StatelessWidget {
  const OrganizationMemberCard({
    super.key,
    required this.name,
    required this.role,
  });

  final String name;
  final String role;

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              CircleAvatar(
                child: Text(name[0]),
              ),
              SizedBox(
                width: getProportionateScreenWidth(ConstantSizes.md),
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: SizeConfig.font20,
                  fontWeight: FontWeight.w800,
                  color: ConstantColors.primary,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(ConstantSizes.sm),
              right: getProportionateScreenWidth(ConstantSizes.sm),
              top: getProportionateScreenHeight(ConstantSizes.xs),
              bottom: getProportionateScreenHeight(ConstantSizes.xs),
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: ConstantColors.primary,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Badge(
              backgroundColor: Colors.transparent,
              textColor: ConstantColors.primary,
              label: Text(
                role,
                style: TextStyle(
                  fontSize: SizeConfig.font12,
                  color: ConstantColors.primary,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
