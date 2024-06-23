import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/domain/models/organizationMember.dart';
import 'package:estegatha/features/organization/presentation/view/create/invite_to_organization_page.dart';
import 'package:estegatha/features/organization/presentation/view/main/organization_detail_page.dart';
import 'package:estegatha/features/organization/presentation/view/setting/change_member_status_screen.dart';
import 'package:estegatha/features/organization/presentation/view/setting/delete_members_screen.dart';
import 'package:estegatha/features/organization/presentation/view/setting/members_status_screen.dart';
import 'package:estegatha/features/organization/presentation/view/setting/widgets/organization_setting_item.dart';
import 'package:estegatha/features/organization/presentation/view/setting/widgets/settings_card_carousel.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_state.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
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
    bool isOwner = false;

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
                Navigator.pop(context, true);
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
          print("STATE: $state");
          if (state is OrganizationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrganizationDetailSuccess) {
            SizeConfig().init(context);
            isOwner = state.members!.any((member) =>
                member.userId ==
                    context.read<UserCubit>().getCurrentUser()?.id &&
                (member.role == 'OWNER' || member.role == 'ADMIN'));
            if (!isOwner) {
              return MemberSettingScreen(
                organization: state.organization,
                members: state.members!,
              );
            } else {
              return OwnerSettingScreen(
                organization: state.organization,
                members: state.members!,
              );
            }
          } else if (state is OrganizationFailure) {
            return const Center(
                child: Text('Failed to load organization data'));
          } else {
            return const Loader();
          }
        },
      ),
    );
  }
}

class MemberSettingScreen extends StatelessWidget {
  final Organization organization;
  final List<OrganizationMember> members;

  const MemberSettingScreen(
      {super.key, required this.organization, required this.members});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom:
                getProportionateScreenHeight(ConstantSizes.bottomNavBarHeight),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(ConstantSizes.sm)),
                child: const SettingCardCarousel(isOwner: false),
              ),
              const SectionHeading(title: "Organization settings"),
              Column(
                children: [
                  OrganizationSettingItem(
                    label: "View Members status",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MembersStatusScreen(members: members);
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
                              organizationCode: organization.organizationCode!,
                              name: organization.name!,
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
                          .leaveOrganization(context, organization.id!);

                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const MainNavMenu(),
                        withNavBar: false,
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OwnerSettingScreen extends StatelessWidget {
  final Organization organization;
  final List<OrganizationMember> members;

  const OwnerSettingScreen(
      {super.key, required this.organization, required this.members});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom:
                getProportionateScreenHeight(ConstantSizes.bottomNavBarHeight),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(ConstantSizes.sm)),
                child: const SettingCardCarousel(
                  isOwner: true,
                ),
              ),
              const SectionHeading(title: "Organization Details"),
              OrganizationSettingItem(
                label: "Edit Organization Name",
                onTap: () {},
              ),
              const SectionHeading(title: "Organization Management"),
              Column(
                children: [
                  OrganizationSettingItem(
                    label: "Change Members Status",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ChangeMemberStatusScreen(
                              members: members,
                              orgId: organization.id!,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  OrganizationSettingItem(
                    label: "Add Organization Members",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return InviteToOrganizationPage(
                              organizationCode: organization.organizationCode!,
                              name: organization.name!,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  OrganizationSettingItem(
                    label: "Delete Organization Members",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DeleteMembersScreen(
                              organization: organization,
                              members: members,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  OrganizationSettingItem(
                    label: "Leave Organization",
                    onTap: () {
                      context
                          .read<OrganizationCubit>()
                          .leaveOrganization(context, organization.id!);

                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const MainNavMenu(),
                        withNavBar: false,
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
