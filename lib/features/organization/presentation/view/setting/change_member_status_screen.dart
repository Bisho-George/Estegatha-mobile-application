import 'package:estegatha/features/organization/domain/models/organizationMember.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/utils/common/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeMemberStatusScreen extends StatefulWidget {
  final int orgId;
  final List<OrganizationMember> members;
  const ChangeMemberStatusScreen(
      {super.key, required this.members, required this.orgId});

  @override
  State<ChangeMemberStatusScreen> createState() =>
      _ChangeMemberStatusScreenState();
}

class _ChangeMemberStatusScreenState extends State<ChangeMemberStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: Icons.arrow_back,
        leadingOnPressed: () {
          Navigator.pop(context);
        },
        title: const Text(
          'Change Members Status',
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
              itemCount: widget.members.length,
              itemBuilder: (context, index) {
                final member = widget.members[index];
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(ConstantSizes.md),
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
                            width:
                                getProportionateScreenWidth(ConstantSizes.md),
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
                        width: getProportionateScreenWidth(120),
                        height: getProportionateScreenHeight(38),
                        padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(ConstantSizes.sm),
                          right: getProportionateScreenWidth(ConstantSizes.sm),
                          top: getProportionateScreenHeight(ConstantSizes.xs),
                          bottom:
                              getProportionateScreenHeight(ConstantSizes.xs),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: ConstantColors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: DropdownButton<String>(
                          value: member.role,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            size: getProportionateScreenHeight(28),
                            color: ConstantColors.darkGrey,
                          ),
                          elevation: 16,
                          style: const TextStyle(color: ConstantColors.primary),
                          underline: Container(
                            color: Colors.transparent,
                          ),
                          isExpanded: true,
                          // onChanged: (String? newValue) async {
                          //   if (newValue != null) {
                          //     setState(() {
                          //       member.role = newValue;
                          //     });
                          //     await context
                          //         .read<OrganizationCubit>()
                          //         .changeMemberRole(context, widget.orgId,
                          //             member.userId!, newValue);
                          //   }
                          // },
                          onChanged: (String? newValue) async {
                            if (newValue != null) {
                              final success = await context
                                  .read<OrganizationCubit>()
                                  .changeMemberRole(context, widget.orgId,
                                      member.userId!, newValue);
                              if (success) {
                                setState(() {
                                  member.role = newValue;
                                });
                              }
                            }
                          },
                          items: <String>['MEMBER', 'ADMIN', 'MONITOR', 'OWNER']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: SizeConfig.font14,
                                  color: ConstantColors.primary,
                                ),
                              ),
                            );
                          }).toList(),
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
  }
}
