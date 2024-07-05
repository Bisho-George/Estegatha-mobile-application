import 'package:estegatha/features/organization/presentation/view_model/current_organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/current_organization_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/sizes.dart';
import '../../../../organization/domain/models/organization.dart';

class OrganizationWidget extends StatelessWidget {
  const OrganizationWidget({super.key, required this.organization});

  final Organization organization;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentOrganizationCubit, CurrentOrganizationState>(
      builder: (context, state) {
        final isSelected = state.organizationId == organization.id;
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
            borderRadius: isSelected
                ? const BorderRadius.only(bottomLeft: Radius.circular(20))
                : BorderRadius.zero,
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: ConstantSizes.defaultSpace,
              vertical: ConstantSizes.spaceBtwItems),
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
                    child: Center(
                      child: Text(
                        '${organization.name?[0]}',
                        style: const TextStyle(
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
                  Text(
                    organization.name ?? '',
                    style: const TextStyle(
                      color: ConstantColors.primary,
                      fontSize: ConstantSizes.fontSizeMd,
                      fontWeight: ConstantSizes.fontWeightBold,
                    ),
                  ),
                ],
              ),
              if (isSelected) const Spacer(),
              if (isSelected)
                const Icon(
                  Icons.check,
                  size: 32,
                  color: ConstantColors.primary,
                ),
            ],
          ),
        );
      },
    );
  }
}
