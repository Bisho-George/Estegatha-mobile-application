import 'package:estegatha/features/organization/presentation/view/create/invite_to_organization_page.dart';
import 'package:estegatha/features/organization/presentation/view/setting/members_status_screen.dart';
import 'package:estegatha/features/organization/presentation/view/setting/widgets/organization_setting_item.dart';
import 'package:estegatha/features/organization/presentation/view/setting/widgets/settings_card_carousel.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_state.dart';
import 'package:estegatha/main_menu.dart';

import 'package:estegatha/utils/common/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class OrganizationSettingsScreen extends StatelessWidget {
  final int organizationId;
  const OrganizationSettingsScreen({super.key, required this.organizationId});

  @override
  Widget build(BuildContext context) {
    context.read<OrganizationCubit>().getOrganizationById(organizationId);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          getProportionateScreenHeight(ConstantSizes.appBarHeight),
        ),
        child: BlocBuilder<OrganizationCubit, OrganizationState>(
          builder: (context, state) {
            String appBarTitle = "";
            if (state is OrganizationDetailSuccess) {
              appBarTitle = state.organization.name!;
            }
            return CustomAppBar(
              leadingIcon: Icons.arrow_back,
              leadingOnPressed: () {
                Navigator.pop(context);
              },
              title: Text(
                appBarTitle,
                style: TextStyle(
                  fontSize: SizeConfig.font20,
                  color: ConstantColors.primary,
                ),
              ),
              showBackArrow: false,
            );
          },
        ),
      ),
      body: BlocBuilder<OrganizationCubit, OrganizationState>(
        builder: (context, state) {
          if (state is OrganizationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrganizationDetailSuccess) {
            SizeConfig().init(context);
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: getProportionateScreenHeight(
                      ConstantSizes.bottomNavBarHeight),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical:
                              getProportionateScreenHeight(ConstantSizes.sm)),
                      child: const SettingCardCarousel(),
                    ),
                    const SectionHeading(title: "Organization settings"),
                    OrganizationSettingItem(
                      label: "My Role",
                      onTap: () {},
                    ),
                    OrganizationSettingItem(
                      label: "View Members status",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MembersStatusScreen(
                                  members: state.members ?? []);
                            },
                          ),
                        );
                      },
                    ),
                    OrganizationSettingItem(
                      label: "Invite members to organization",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return InviteToOrganizationPage(
                                organizationCode:
                                    state.organization.organizationCode!,
                                name: state.organization.name!,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    OrganizationSettingItem(
                      label: "Leave organization",
                      onTap: () {
                        context
                            .read<OrganizationCubit>()
                            .leaveOrganization(context, organizationId);

                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const MainNavMenu(),
                          withNavBar: false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (state is OrganizationFailure) {
            return Center(child: Text('Failed to load organization data'));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
