import 'package:estegatha/features/organization/domain/models/member.dart';
import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/presentation/view/main/organization_detail_page.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinalJoinOrganizationPage extends StatelessWidget {
  const FinalJoinOrganizationPage({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Organization?>(
        future: context.read<OrganizationCubit>().getOrganizationByCode(code),
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
                    vertical: ConstantSizes.spaceBtwSections * 2,
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
                    const SizedBox(
                      height: ConstantSizes.spaceBtwSections,
                    ),
                    const Text(
                      "Here's how is waiting for you:",
                      style: TextStyle(
                        color: ConstantColors.darkGrey,
                        fontSize: ConstantSizes.fontSizeLg,
                      ),
                    ),

                    const SizedBox(
                      height: ConstantSizes.spaceBtwSections * 3,
                    ),

                    // create a circle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: org!.memberIds!.map((id) {
                        return FutureBuilder<Member?>(
                          future: context.read<UserCubit>().getUserById(id),
                          builder: (BuildContext context,
                              AsyncSnapshot<Member?> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator(); // Show loading spinner while waiting for future to complete
                            } else if (snapshot.hasError) {
                              return Text(
                                  'Error: ${snapshot.error}'); // Show error message if future completed with an error
                            } else {
                              final user = snapshot.data;
                              return Container(
                                height: 100,
                                width: 100,
                                decoration: const BoxDecoration(
                                  color: ConstantColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    // Only show the first character of the name
                                    (user?.name ?? '')[0].toUpperCase(),
                                    style: const TextStyle(
                                      color: ConstantColors.white,
                                      fontSize: ConstantSizes.headingLg,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(
                      height: ConstantSizes.spaceBtwSections * 2,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomElevatedButton(
                            onPressed: () {
                              final userCubit = context.read<UserCubit>();
                              final user =
                                  (userCubit.state as UserSuccess).user;
                              final updatedOrganizationIds =
                                  List<int>.from(user.organizationIds ?? []);

                              final updatedUser = Member(
                                id: user.id,
                                name: user.name,
                                email: user.email,
                                password: user.password,
                                organizationIds: updatedOrganizationIds,
                              );

                              userCubit.setUser(updatedUser);
                              // pop all pages before navigating to the organization detail page
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrganizationDetailPage(
                                    organizationId: org.id,
                                  ),
                                ),
                              );
                            },
                            labelText: "Join"),
                        const SizedBox(
                          height: ConstantSizes.spaceBtwSections,
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

    // todo: get organization object by the code entered
  }
}
