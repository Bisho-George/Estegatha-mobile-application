import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/domain/models/organizationMember.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/main_menu.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class FinalJoinOrganizationPage extends StatelessWidget {
  const FinalJoinOrganizationPage({super.key, required this.orgId});

  final int orgId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Organization?>(
        future: context.read<OrganizationCubit>().getOrganizationById(orgId),
        builder: (BuildContext context, AsyncSnapshot<Organization?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
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
                      height: ConstantSizes.spaceBtwSections * 4,
                    ),
                    FutureBuilder<List<OrganizationMember>>(
                      future: context
                          .read<OrganizationCubit>()
                          .getOrganizationMembers(orgId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final members = snapshot.data ?? [];
                          return Expanded(
                            child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 5,
                              ),
                              itemCount: members.length,
                              itemBuilder: (context, index) {
                                final member = members[index];
                                return GridTile(
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      color: ConstantColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        member.username![0].toUpperCase(),
                                        style: const TextStyle(
                                          color: ConstantColors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => OrganizationDetailPage(
                              //       organizationId: org.id,
                              //     ),
                              //   ),
                              // );
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: const MainNavMenu(),
                                withNavBar: false,
                              );
                              // MaterialPageRoute(
                              //   builder: (context) => MainNavMenu(),
                              // ),

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainNavMenu(),
                                ),
                              );
                            },
                            labelText: "Join"),
                        const SizedBox(
                          height: ConstantSizes.md,
                        ),
                        CustomElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          labelText: "Cancel",
                          isPrimary: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
