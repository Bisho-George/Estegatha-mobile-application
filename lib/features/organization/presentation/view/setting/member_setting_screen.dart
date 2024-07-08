import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/domain/models/organizationMember.dart';
import 'package:estegatha/features/organization/presentation/view/create/invite_to_organization_page.dart';
import 'package:estegatha/features/organization/presentation/view/setting/members_status_screen.dart';
import 'package:estegatha/features/organization/presentation/view/setting/widgets/organization_setting_item.dart';
import 'package:estegatha/features/organization/presentation/view/setting/widgets/settings_card_carousel.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/features/organization/presentation/view_model/leave_organization/leave_organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/leave_organization/leave_organization_state.dart';
import 'package:estegatha/main_menu.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/constant/variables.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberSettingScreen extends StatelessWidget {
  Organization organization;
  final List<OrganizationMember> members;

  MemberSettingScreen(
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
                            return BlocListener<LeaveOrganizationCubit,
                                LeaveOrganizationState>(
                              listener: (context, state) {
                                print("State=======Leave: $state");
                                if (state is LeaveOrganizationLoading) {
                                  // Show loading dialog
                                  showDialog(
                                    context: context,
                                    builder: (context) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else if (state is LeaveOrganizationSuccess) {
                                  // Handle success state
                                  Navigator.of(context)
                                      .pop(); // Close the dialog

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MainNavMenu()),
                                  );
                                } else if (state is LeaveOrganizationFailure) {
                                  // Handle failure state
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                  HelperFunctions.showSnackBar(
                                      context, state.errorMessage);
                                }
                              },
                              child: AlertDialog(
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
                                      Navigator.of(context)
                                          .pop(); // Close the dialog first
                                      await context
                                          .read<LeaveOrganizationCubit>()
                                          .leaveOrganization(
                                            organization.id!,
                                          );
                                    },
                                  ),
                                ],
                              ),
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
