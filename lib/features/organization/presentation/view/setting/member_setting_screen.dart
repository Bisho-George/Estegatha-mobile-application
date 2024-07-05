import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/domain/models/organizationMember.dart';
import 'package:estegatha/features/organization/presentation/view/create/invite_to_organization_page.dart';
import 'package:estegatha/features/organization/presentation/view/setting/members_status_screen.dart';
import 'package:estegatha/features/organization/presentation/view/setting/widgets/organization_setting_item.dart';
import 'package:estegatha/features/organization/presentation/view/setting/widgets/settings_card_carousel.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/main_menu.dart';

import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/constant/variables.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MemberSettingScreen extends StatelessWidget {
  final Organization organization;
  final List<OrganizationMember> members;

  const MemberSettingScreen(
      {super.key, required this.organization, required this.members});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: getProportionateScreenHeight(
                  ConstantSizes.bottomNavBarHeight),
            ),
            child: Column(
              children: <Widget>[
                SettingCardCarousel(
                    helpNotes: ConstantVariables.memberHelpNotes),
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
                                organizationCode:
                                    organization.organizationCode!,
                                name: organization.name!,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    OrganizationSettingItem(
                      label: "Leave Organization",
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Leave Organization"),
                              content: const Text(
                                  "Are you sure you want to leave the organization?"),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text("Leave"),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    final res = await context
                                        .read<OrganizationCubit>()
                                        .leaveOrganization(
                                          context,
                                          organization.id!,
                                        );
                                    if (res == true) {
                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: const MainNavMenu(),
                                        withNavBar: false,
                                      );
                                    } else if (res == false) {
                                      HelperFunctions.showSnackBar(context,
                                          "Failed to leave organization");
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
