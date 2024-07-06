import 'package:estegatha/features/home/presentation/view_models/organization_member_cubit.dart';
import 'package:estegatha/features/home/presentation/views/widgets/animated_organization_members_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AnimatedOrganizationMembersSliverListBlocConsumer extends StatelessWidget {
  const AnimatedOrganizationMembersSliverListBlocConsumer({super.key, required this.isExpanded});
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizationMemberHomeCubit, OrganizationMemberHomeState>(
      builder: (context, state) {
        if (state is OrganizationMemberHomeSuccess) {
          return AnimatedOrganizationMembersSliverList(members: state.members, isExpanded: isExpanded);
        } else if (state is OrganizationMemberHomeFailure) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text("No members found"),
            ),
          );
        }
        else {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
