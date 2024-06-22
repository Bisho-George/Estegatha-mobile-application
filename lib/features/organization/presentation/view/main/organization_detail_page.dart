import 'package:estegatha/features/organization/presentation/view/widgets/posts_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/members_list.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/organization_app_bar.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/organization_tab_status.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_state.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: CircularProgressIndicator(),
        ),
        SizedBox(height: ConstantSizes.sm.h),
        const Text("Loading...")
      ],
    );
  }
}

class OrganizationDetailPage extends StatelessWidget {
  final int organizationId;

  const OrganizationDetailPage({super.key, required this.organizationId});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    context.read<OrganizationCubit>().getOrganizationById(organizationId);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: OrganizationAppBar(),
        body: TabBarView(
          children: [
            // First tab content => Track location
            ListView(
              children: [
                BlocBuilder<OrganizationCubit, OrganizationState>(
                  builder: (context, state) {
                    print("State: $state");
                    if (state is OrganizationLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is OrganizationFailure) {
                      return Center(child: Text(state.errMessage));
                    } else if (state is OrganizationDetailSuccess) {
                      return MembersList(
                          badgeLabel: "Track", members: state.members ?? []);
                    } else {
                      return const Loader();
                    }
                  },
                ),
                const SectionHeading(title: 'Track status'),
                const TabStatus(
                  image: ConstantImages.organizationTrackIcon,
                  title: 'No Danger Status Detected',
                  subtitle:
                      'Your organization may have not enabled location tracking.',
                ),
              ],
            ),
            // Second tab content => Health
            ListView(
              children: [
                BlocBuilder<OrganizationCubit, OrganizationState>(
                  builder: (context, state) {
                    if (state is OrganizationLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is OrganizationFailure) {
                      return Center(child: Text(state.errMessage));
                    } else if (state is OrganizationDetailSuccess) {
                      return MembersList(
                          badgeLabel: "Status", members: state.members ?? []);
                    } else {
                      return const Loader();
                    }
                  },
                ),
                const SectionHeading(title: 'Health status'),
                const TabStatus(
                  image: ConstantImages.organizationHealthIcon,
                  title: 'No Health Status Detected',
                  subtitle:
                      'Your organization may have not enabled health tracking.',
                ),
              ],
            ),
            // Third tab content => Posts
            ListView(
              children: [
                BlocBuilder<OrganizationCubit, OrganizationState>(
                  builder: (context, state) {
                    if (state is OrganizationLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is OrganizationFailure) {
                      return Center(child: Text(state.errMessage));
                    } else if (state is OrganizationDetailSuccess) {
                      return PostsList(posts: state.posts ?? []);
                    } else {
                      return const Text("Error loading posts!");
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
