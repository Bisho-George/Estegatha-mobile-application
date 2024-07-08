import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/domain/models/organizationMember.dart';
import 'package:estegatha/features/organization/presentation/view/create/invite_to_organization_page.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_state.dart';
import 'package:estegatha/features/settings/presentation/view/widgets/organization_member_card.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:estegatha/utils/common/custom_app_bar.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class DeleteMemberScreen extends StatefulWidget {
  final Organization organization;
  final List<OrganizationMember> members;

  const DeleteMemberScreen(
      {super.key, required this.organization, required this.members});

  @override
  State<DeleteMemberScreen> createState() => _DeleteMemberScreenState();
}

class _DeleteMemberScreenState extends State<DeleteMemberScreen> {
  late List<OrganizationMember> _members;

  @override
  void initState() {
    super.initState();
    // exclude the current user from the list if its an owner or admin
    _members = widget.members.where((member) {
      return member.role != 'OWNER' &&
          member.role != 'ADMIN' &&
          member.userId != context.read<UserCubit>().getCurrentUser()?.id;
    }).toList();
    // _members = widget.members;
  }

  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SectionHeading(title: 'Members status'),
          if (_members.isEmpty)
            SizedBox(
              height: getProportionateScreenHeight(550),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/members_not_found.png',
                    width: getProportionateScreenWidth(200),
                    height: getProportionateScreenHeight(200),
                  ),
                  Text(
                    'No members to delete.',
                    style: TextStyle(
                      color: ConstantColors.primary,
                      fontSize: SizeConfig.font22,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(ConstantSizes.md),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InviteToOrganizationPage(
                            name: widget.organization.name!,
                            organizationCode:
                                widget.organization.organizationCode!,
                          ),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: ConstantColors.grey),
                    ),
                    child: Text(
                      'Invite Members',
                      style: TextStyle(
                          color: ConstantColors.primary,
                          fontSize: SizeConfig.font14),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _members.length,
              itemBuilder: (context, index) {
                final member = _members[index];
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
                                    widget.organization.id!, member.userId!);

                            if (widget.members.length > 1) {
                              // delete member from members list
                              setState(() {
                                _members.removeAt(index);
                              });

                              HelperFunctions.showCustomToast(
                                context: context,
                                title: const Text(
                                  'Member removed successfully!',
                                  style:
                                      TextStyle(color: ConstantColors.primary),
                                ),
                                type: ToastificationType.success,
                                position: Alignment.bottomCenter,
                                duration: 3,
                                icon: const Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: ConstantColors.primary,
                                ),
                                backgroundColor: ConstantColors.secondary,
                              );
                            }
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
  }
}
