import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../organization/presentation/view_model/user_organizations_cubit.dart';
import 'organization_list_view.dart';

class OrganizationsBlocBuilder extends StatelessWidget {
  const OrganizationsBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserOrganizationsCubit, UserOrganizationsState>(
      builder: (context, state) {
        if (state is UserOrganizationsSuccess) {
          return Expanded(
            child: OrganizationsListView(
                organizations: state.organizations),
          );
        }
        if (state is UserOrganizationsFailure) {
          return const Expanded(
            child:  Center(
              child:  Text("No organizations found"),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        )
        ;
      },
    );
  }
}
