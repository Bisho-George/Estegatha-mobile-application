import 'package:estegatha/features/edit_account/presentation/pages/edit_account_menu.dart';
import 'package:estegatha/features/organization/presentation/view/boarding_page.dart';
import 'package:estegatha/features/organization/presentation/view/join/join_organization_page.dart';
import 'package:estegatha/features/organization/presentation/view/setting/organization_settings_screen.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/features/settings/presentation/view/widgets/setting_item.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:estegatha/utils/common/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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
              SettingItem(
                label: "Organization Management",
                icon: Icons.groups,
                onTap: () {
                  // Assuming you have a method to navigate to the organization-specific settings page
                  // You can pass the organization ID from the state to that method
                  navigateToOrganizationSettings(
                      context, 1); //TODO: Replace 1 with the organization ID
                },
              ),
              SettingItem(
                label: "Location Sharing",
                icon: Icons.send,
                onTap: () {},
              ),
              const SectionHeading(title: "General Settings"),

              // TODO: Temporary solution to navigate to the organization settings page
              SettingItem(
                label: "Create Organization",
                icon: Icons.edit,
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: OrganizationBoardingPage(
                      name:
                          context.read<UserCubit>().getCurrentUser()!.username,
                    ),
                    withNavBar: false,
                  );
                },
              ),
              SettingItem(
                label: "Join Organization",
                icon: Icons.group_add_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const JoinOrganizationPage(),
                    ),
                  );
                },
              ),
              SettingItem(
                label: "Account",
                icon: Icons.account_box_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditAccountMenu(
                        parentContext: context,
                      ),
                    ),
                  );
                },
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
