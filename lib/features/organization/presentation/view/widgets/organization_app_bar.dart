import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_state.dart';

import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:estegatha/features/organization/presentation/view_model/user_organizations_cubit.dart'
    as user_cubit;

class OrganizationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String organizationName;
  final List<Organization> organizations;

  const OrganizationAppBar(
      {super.key, required this.organizationName, required this.organizations});
  @override
  Size get preferredSize => Size.fromHeight(124.r);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        width: double.infinity.w,
        padding: EdgeInsets.symmetric(horizontal: ConstantSizes.md.w),
        height: 80.r,
        color: ConstantColors.primary,
        child: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: ConstantColors.grey,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: ConstantColors.primary,
                    ),
                    onPressed: () {
                      // Handle settings button press
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 230.w,
                  height: 32.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: ConstantColors.grey,
                    borderRadius: BorderRadius.circular(30.0.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Organization>(
                      value: organizations.isNotEmpty
                          ? organizations.firstWhere(
                              (org) => org.name == organizationName,
                              orElse: () => organizations.first,
                            )
                          : null,
                      dropdownColor: ConstantColors.grey,
                      items: organizations.map((Organization organization) {
                        return DropdownMenuItem<Organization>(
                          value: organization,
                          child: Text(
                            organization.name!,
                            style: TextStyle(
                                fontSize: ConstantSizes.fontSizeMd.sp,
                                fontWeight: ConstantSizes.fontWeightSemiBold,
                                color: ConstantColors.primary),
                          ),
                        );
                      }).toList(),
                      onChanged: (Organization? selectedOrganization) {
                        // Handle organization selection
                        // You might need to update the state with the selected organization's name
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: ConstantColors.grey,
                    borderRadius: BorderRadius.circular(30.0.r),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.inbox,
                      color: ConstantColors.primary,
                    ),
                    onPressed: () {
                      // Handle inbox button press
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottom: TabBar(
        unselectedLabelColor: ConstantColors.primary,
        labelStyle: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: ConstantSizes.fontSizeSm.sp,
            fontWeight: ConstantSizes.fontWeightSemiBold,
            color: ConstantColors.primary),
        tabs: [
          Tab(
              icon: ImageIcon(
                const AssetImage(
                  ConstantImages.organizationTrackIcon,
                ),
                color: ConstantColors.iconPrimary,
                size: 20.r,
              ),
              text: 'Track location'),
          Tab(
              icon: ImageIcon(
                const AssetImage(ConstantImages.organizationHealthIcon),
                size: 20.r,
                color: ConstantColors.iconPrimary,
              ),
              text: 'Health status'),
          Tab(
              icon: ImageIcon(
                const AssetImage(ConstantImages.organizationPostIcon),
                size: 20.r,
                color: ConstantColors.iconPrimary,
              ),
              text: 'Posts'),
        ],
      ),
    );
  }
}

class CustomOrganizationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final int organizationId;

  const CustomOrganizationAppBar({Key? key, required this.organizationId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<user_cubit.UserOrganizationsCubit,
        user_cubit.UserOrganizationsState>(
      builder: (context, userState) {
        List<Organization> organizations = [];
        if (userState is user_cubit.UserOrganizationsSuccess) {
          organizations = userState.organizations;
        }

        return BlocBuilder<OrganizationCubit, OrganizationState>(
          builder: (context, orgState) {
            String organizationName = "";
            if (orgState is OrganizationDetailSuccess) {
              organizationName = orgState.organization.name!;
            } else if (userState is UserOrganizationsSuccess &&
                organizations.isNotEmpty) {
              // Fallback to the first organization from UserOrganizationsCubit if available
              organizationName = organizations.first.name!;
            }

            return OrganizationAppBar(
              organizationName: organizationName,
              organizations: organizations,
            );
          },
        );
      },
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(124.r); // Adjust the height as needed
}
