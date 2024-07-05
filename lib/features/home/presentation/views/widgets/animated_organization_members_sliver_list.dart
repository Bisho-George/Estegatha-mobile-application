import 'package:flutter/cupertino.dart';

import '../../../../organization/domain/models/organizationMember.dart';
import 'draggable_scroll_sheet_list_item.dart';

class AnimatedOrganizationMembersSliverList extends StatelessWidget {
  const AnimatedOrganizationMembersSliverList({
    super.key,
    required this.members,
    required this.isExpanded
  });
  final List<OrganizationMember> members;
  final bool isExpanded;



  @override
  Widget build(BuildContext context) {
    return SliverAnimatedList(
      initialItemCount: isExpanded ? members.length : members.length > 3 ? 3 : members.length,
      itemBuilder: (context, index, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: DraggableScrollSheetListItem(member: members[index]),
        );
      },
    );
  }
}
