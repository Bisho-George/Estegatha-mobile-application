import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/domain/models/organizationMember.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinalJoinOrganizationPage extends StatelessWidget {
  const FinalJoinOrganizationPage({super.key, required this.orgId});

  final int orgId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Organization?>(
        future: context.read<OrganizationCubit>().getOrganizationById(orgId),
        builder: (BuildContext context, AsyncSnapshot<Organization?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Show loading spinner while waiting for future to complete
          } else if (snapshot.hasError) {
            return Text(
                'Error: ${snapshot.error}'); // Show error message if future completed with an error
          } else {
            final org = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Join Organization',
                  style: TextStyle(
                    color: ConstantColors.primary,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: ConstantSizes.spaceBtwSections,
                    horizontal: ConstantSizes.defaultSpace),
                child: Column(
                  children: [
                    Text(
                      "Great, You are about to join the ${org?.name} organization.",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: ConstantColors.primary,
                        fontSize: ConstantSizes.headingMd,
                        fontWeight: ConstantSizes.fontWeightBold,
                      ),
                    ),

                    const Text(
                      "Here's how is waiting for you:",
                      style: TextStyle(
                        color: ConstantColors.darkGrey,
                        fontSize: ConstantSizes.fontSizeLg,
                      ),
                    ),

                    const SizedBox(
                      height: ConstantSizes.spaceBtwSections,
                    ),

                    FutureBuilder<List<OrganizationMember>>(
                      future: context
                          .read<OrganizationCubit>()
                          .getOrganizationMembers(orgId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Show loading spinner
                        } else if (snapshot.hasError) {
                          return Text(
                              'Error: ${snapshot.error}'); // Show error message
                        } else {
                          // Assuming data is successfully loaded
                          final members = snapshot.data ?? [];
                          return Expanded(
                            child: ListView.builder(
                              itemCount: members.length,
                              itemBuilder: (context, index) {
                                final member = members[index];
                                return ListTile(
                                  leading: Container(
                                    height:
                                        100, // Specify the height of the circle
                                    width:
                                        100, // Specify the width of the circle
                                    decoration: BoxDecoration(
                                      color: ConstantColors
                                          .primary, // Use your primary color here
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        member.username![0]
                                            .toUpperCase(), // Display the first letter of the member's name
                                        style: TextStyle(
                                          color: ConstantColors
                                              .white, // Use your text color here
                                          fontSize: ConstantSizes
                                              .headingLg, // Use your font size here
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(member.username!),
                                  // Add more member details here
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),

                    const SizedBox(
                      height: ConstantSizes.spaceBtwSections * 2,
                    ),

                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     CustomElevatedButton(
                    //         onPressed: () {
                    //           final userCubit = context.read<UserCubit>();
                    //           final user =
                    //               (userCubit.state as UserSuccess).user;
                    //           final updatedOrganizationIds =
                    //               List<int>.from(user.organizationIds ?? []);

                    //           final updatedUser = Member(
                    //             id: user.id,
                    //             name: user.name,
                    //             email: user.email,
                    //             password: user.password,
                    //             organizationIds: updatedOrganizationIds,
                    //           );

                    //           userCubit.setUser(updatedUser);
                    //           // pop all pages before navigating to the organization detail page
                    //           Navigator.pop(context);
                    //           // Navigator.pushReplacement(
                    //           //   context,
                    //           //   MaterialPageRoute(
                    //           //     builder: (context) => OrganizationDetailPage(
                    //           //       organizationId: org.id,
                    //           //     ),
                    //           //   ),
                    //           // );
                    //           Navigator.pushReplacement(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) => HomePage(),
                    //             ),
                    //           );
                    //         },
                    //         labelText: "Join"),
                    //     const SizedBox(
                    //       height: ConstantSizes.md,
                    //     ),
                    //     CustomElevatedButton(
                    //       onPressed: () {
                    //         Navigator.pop(context);
                    //       },
                    //       labelText: "Cancel",
                    //       isPrimary: false,
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
