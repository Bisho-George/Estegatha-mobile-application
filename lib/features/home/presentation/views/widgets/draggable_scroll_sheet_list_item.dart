import 'package:estegatha/features/organization/domain/models/organizationMember.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constant/colors.dart';

class DraggableScrollSheetListItem extends StatelessWidget {
  const DraggableScrollSheetListItem({super.key, required this.member});

  final OrganizationMember member;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 20,
        /*backgroundImage: AssetImage(''),*/
        backgroundColor: ConstantColors.primary,
        child: Text(
          member.username![0].toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: ConstantSizes.fontSizeMd,
          ),
        )
      ),
      title: Text(member.username ?? ''),
      subtitle: Text(member.role ?? ''),
    );
  }
}
