import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/domain/models/organizationMember.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_state.dart';
import 'package:estegatha/features/settings/presentation/view/widgets/organization_member_card.dart';
import 'package:estegatha/utils/common/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

class DeleteMembersScreen extends StatelessWidget {
  final Organization organization;
  final List<OrganizationMember> members;

  const DeleteMembersScreen(
      {super.key, required this.organization, required this.members});

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: CustomAppBar(
  //       leadingIcon: Icons.arrow_back,
  //       leadingOnPressed: () {
  //         Navigator.pop(context);
  //       },
  //       title: const Text(
  //         'Remove Organization Members',
  //         style: TextStyle(color: ConstantColors.primary),
  //       ),
  //       showBackArrow: false,
  //     ),
  //     body: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const SectionHeading(title: 'Members status'),
  //         Expanded(
  //           child: ListView.builder(
  //             itemCount: members.length,
  //             itemBuilder: (context, index) {
  //               final member = members[index];
  //               return Container(
  //                 padding: EdgeInsets.symmetric(
  //                   horizontal: getProportionateScreenWidth(ConstantSizes.md),
  //                   vertical:
  //                       getProportionateScreenHeight(ConstantSizes.md + 6),
  //                 ),
  //                 decoration: const BoxDecoration(
  //                   border: Border(
  //                     bottom: BorderSide(
  //                       color: ConstantColors.borderSecondary,
  //                       width: 1,
  //                     ),
  //                   ),
  //                 ),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: <Widget>[
  //                     Row(
  //                       children: [
  //                         CircleAvatar(
  //                           child: Text(member.username![0]),
  //                         ),
  //                         SizedBox(
  //                           width:
  //                               getProportionateScreenWidth(ConstantSizes.md),
  //                         ),
  //                         Text(
  //                           member.username!,
  //                           style: TextStyle(
  //                             fontSize: SizeConfig.font20,
  //                             fontWeight: FontWeight.w800,
  //                             color: ConstantColors.primary,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Container(
  //                       decoration: BoxDecoration(
  //                         color: Colors.transparent,
  //                         border: Border.all(
  //                           color: ConstantColors.error,
  //                           width: 1.0,
  //                         ),
  //                         borderRadius: BorderRadius.circular(50.0),
  //                       ),
  //                       child: IconButton(
  //                         icon: const Icon(
  //                           Icons.delete,
  //                           color: ConstantColors.error,
  //                         ),
  //                         onPressed: () {
  //                           context
  //                               .read<OrganizationCubit>()
  //                               .removeMemberFromOrganization(
  //                                   context, organization.id!, member.userId!);
  //                         },
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    return BlocConsumer<OrganizationCubit, OrganizationState>(
      // TODO: Complete the delete functionality
      listener: (context, state) {
        if (state is RemoveMemberSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Member removed successfully')),
          );
        }
      },
      builder: (context, state) {
        List<OrganizationMember> members = [];
        if (state is OrganizationDetailSuccess) {
          members = state.members!;
        }

        return Scaffold(
          appBar: CustomAppBar(
            leadingIcon: Icons.arrow_back,
            leadingOnPressed: () {
              Navigator.pop(context);
            },
            title: const Text(
              'Remove Organization Members',
              style: TextStyle(color: ConstantColors.primary),
            ),
            showBackArrow: false,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(title: 'Members status'),
              Expanded(
                child: ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            getProportionateScreenWidth(ConstantSizes.md),
                        vertical:
                            getProportionateScreenHeight(ConstantSizes.md + 6),
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: ConstantColors.borderSecondary,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              CircleAvatar(
                                child: Text(member.username![0]),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(
                                    ConstantSizes.md),
                              ),
                              Text(
                                member.username!,
                                style: TextStyle(
                                  fontSize: SizeConfig.font20,
                                  fontWeight: FontWeight.w800,
                                  color: ConstantColors.primary,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: ConstantColors.error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: ConstantColors.error,
                              ),
                              onPressed: () {
                                context
                                    .read<OrganizationCubit>()
                                    .removeMemberFromOrganization(context,
                                        organization.id!, member.userId!);
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
