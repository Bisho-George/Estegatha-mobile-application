import 'package:estegatha/features/home/presentation/view_models/home_view_model.dart';
import 'package:estegatha/features/organization/presentation/view_model/current_organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../organization/domain/models/organization.dart';
import 'organization_widget.dart';

class OrganizationsListView extends StatelessWidget {
  const OrganizationsListView({
    super.key,
    required this.organizations,
  });
  final List<Organization> organizations;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          BlocProvider.of<CurrentOrganizationCubit>(context).setCurrentOrganization(organizations[index].id!);
          BlocProvider.of<OrganizationCubit>(context).getOrganizationMembers(organizations[index].id!);
          BlocProvider.of<HomeCubit>(context).hideOrganizations();
        },
          child: OrganizationWidget(organization: organizations[index])),
      itemCount: organizations.length,
    );
  }
}
