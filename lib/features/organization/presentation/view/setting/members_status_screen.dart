import 'package:estegatha/features/organization/domain/models/organizationMember.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/features/settings/presentation/view/widgets/organization_member_card.dart';
import 'package:estegatha/utils/common/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class MembersStatusScreen extends StatelessWidget {
  final List<OrganizationMember> members;

  const MembersStatusScreen({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: Icons.arrow_back,
        leadingOnPressed: () {
          Navigator.pop(context);
        },
        title: const Text(
          'View members status',
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
                return OrganizationMemberCard(
                    name: member.username!, role: member.role!);
              },
            ),
          ),
        ],
      ),
    );
  }
}
