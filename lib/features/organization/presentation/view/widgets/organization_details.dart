import 'package:estegatha/features/organization/presentation/view/main/organization_detail_page.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizationDetails extends StatelessWidget {
  final int organizationId;

  const OrganizationDetails({required this.organizationId});

  @override
  Widget build(BuildContext context) {
    final organizationCubit = BlocProvider.of<OrganizationCubit>(context);
    organizationCubit.getOrganizationById(organizationId);

    return BlocBuilder<OrganizationCubit, OrganizationState>(
      builder: (context, state) {
        if (state is OrganizationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OrganizationFailure) {
          return Center(child: Text(state.errMessage));
        } else if (state is OrganizationSuccess) {
          final organization = state.organization;
          return Column(
            children: [
              SectionHeading(title: organization!.name ?? ''),
              Text('Hey there! I am ${organization.name}'),
              // Add more details if needed
            ],
          );
        } else {
          return const Loader();
        }
      },
    );
  }
}
