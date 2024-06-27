import 'package:flutter/material.dart';

import '../../../../responsive/size_config.dart';
import '../../../../utils/common/styles/text_styles.dart';
import '../../../../utils/constant/sizes.dart';
import '../../../organization/domain/models/member.dart';
import '../../../organization/domain/models/organizationMember.dart';
import 'member_bubble_widget.dart';
class SosReceivedMembersWidget extends StatelessWidget {
  const SosReceivedMembersWidget({
    super.key,
    required this.members,
  });

  final List<OrganizationMember> members;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: members.length,
            itemBuilder: (context, index) {
              return MemberBubbleWidget(
                name: members[index].username,
              );
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: responsiveHeight(20),
        ),
        Text(
          'Your SOS will be sent to ${members.length} people',
          style: Styles.getDefaultPrimary(
              fontSize: ConstantSizes.fontSizeMd
          ),
        ),
      ],
    );
  }
}