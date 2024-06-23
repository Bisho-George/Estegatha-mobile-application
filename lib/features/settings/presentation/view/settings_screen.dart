import 'package:estegatha/features/organization/presentation/view/setting/organization_settings_screen.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/features/organization/presentation/view_model/current_organization_cubit.dart';
import 'package:estegatha/features/settings/presentation/view/widgets/setting_item.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:estegatha/utils/common/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void logoutHandler(BuildContext context) async {
    BlocProvider.of<UserCubit>(context).logout(context);
  }

  void navigateToOrganizationSettings(
      BuildContext context, int organizationId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrganizationSettingsScreen(
          organizationId: organizationId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          getProportionateScreenHeight(ConstantSizes.appBarHeight),
        ),
        child: CustomAppBar(
          title: Text(
            "Settings",
            style: TextStyle(
              fontSize: SizeConfig.font20,
              color: ConstantColors.primary,
            ),
          ),
          showBackArrow: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom:
                getProportionateScreenHeight(ConstantSizes.bottomNavBarHeight),
          ),
          child: Column(
            children: <Widget>[
              const SectionHeading(title: "Organization settings"),
              BlocBuilder<CurrentOrganizationCubit, CurrentOrganizationState>(
                builder: (context, state) {
                  return SettingItem(
                    label: "Organization Management",
                    icon: Icons.groups,
                    onTap: () {
                      // Assuming you have a method to navigate to the organization-specific settings page
                      // You can pass the organization ID from the state to that method
                      navigateToOrganizationSettings(
                          context, state.organizationId!);
                    },
                  );
                },
              ),
              SettingItem(
                label: "Location Sharing",
                icon: Icons.send,
                onTap: () {},
              ),
              const SectionHeading(title: "General Settings"),
              SettingItem(
                label: "Account",
                icon: Icons.account_box_rounded,
                onTap: () {},
              ),
              SettingItem(
                label: "Privacy & Security",
                icon: Icons.privacy_tip,
                onTap: () {},
              ),
              SettingItem(
                label: "Support",
                icon: Icons.support_rounded,
                onTap: () {},
              ),
              SettingItem(
                label: "About",
                icon: Icons.info_rounded,
                onTap: () {},
              ),
              SettingItem(
                label: "Logout",
                icon: Icons.logout,
                onTap: () => logoutHandler(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
