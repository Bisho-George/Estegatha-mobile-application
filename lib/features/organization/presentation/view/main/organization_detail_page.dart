import 'package:estegatha/features/organization/domain/models/member.dart';
import 'package:estegatha/features/organization/domain/models/post.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/organization_tab_status.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_state.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrganizationDetailPage extends StatelessWidget {
  final int organizationId;

  const OrganizationDetailPage({super.key, required this.organizationId});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final organizationCubit = BlocProvider.of<OrganizationCubit>(context);
    // organizationCubit.getOrganizationData(organizationId);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(124.r),
          child: AppBar(
            flexibleSpace: Container(
              width: double.infinity.w,
              padding: EdgeInsets.symmetric(horizontal: ConstantSizes.md.w),
              height: 80.r,
              color: ConstantColors.primary,
              child: Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 40.r,
                        height: 40.r,
                        decoration: BoxDecoration(
                          color: ConstantColors.grey,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.settings,
                            color: ConstantColors.primary,
                          ),
                          onPressed: () {
                            // Handle settings button press
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 230.w,
                        height: 32.h,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          color: ConstantColors.grey,
                          borderRadius: BorderRadius.circular(30.0.r),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: 'Graduation project',
                            dropdownColor: ConstantColors.grey,
                            items: <String>[
                              'Graduation project',
                              'Organization 2',
                              'Organization 3'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontSize: ConstantSizes.fontSizeMd.sp,
                                      fontWeight:
                                          ConstantSizes.fontWeightSemiBold,
                                      color: ConstantColors.primary),
                                ),
                              );
                            }).toList(),
                            onChanged: (_) {
                              // Handle organization selection
                            },
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 40.r,
                        height: 40.r,
                        decoration: BoxDecoration(
                          color: ConstantColors.grey,
                          borderRadius: BorderRadius.circular(30.0.r),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.inbox,
                            color: ConstantColors.primary,
                          ),
                          onPressed: () {
                            // Handle inbox button press
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottom: TabBar(
              unselectedLabelColor: ConstantColors.primary,
              labelStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: ConstantSizes.fontSizeSm.sp,
                  fontWeight: ConstantSizes.fontWeightSemiBold,
                  color: ConstantColors.primary),
              tabs: [
                Tab(
                    icon: ImageIcon(
                      const AssetImage(
                        ConstantImages.organizationTrackIcon,
                      ),
                      color: ConstantColors.iconPrimary,
                      size: 20.r,
                    ),
                    text: 'Track location'),
                Tab(
                    icon: ImageIcon(
                      const AssetImage(ConstantImages.organizationHealthIcon),
                      size: 20.r,
                      color: ConstantColors.iconPrimary,
                    ),
                    text: 'Health status'),
                Tab(
                    icon: ImageIcon(
                      const AssetImage(ConstantImages.organizationPostIcon),
                      size: 20.r,
                      color: ConstantColors.iconPrimary,
                    ),
                    text: 'Posts'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // First tab content => Track location
            ListView(
              children: [
                BlocBuilder<OrganizationCubit, OrganizationState>(
                  builder: (context, state) {
                    if (state is OrganizationLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is OrganizationFailure) {
                      return Center(child: Text(state.errMessage));
                    } else if (state is OrganizationSuccess) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.members.length,
                        itemBuilder: (context, index) {
                          Member member = state.members[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: ConstantColors.grey,
                                  width: 0.5.w,
                                ),
                              ),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(
                                  member.username[0],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                member.username,
                                style: const TextStyle(
                                  color: ConstantColors.primary,
                                  fontSize: ConstantSizes.fontSizeLg,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text('Member ID: ${member.id}'),
                              trailing: SizedBox(
                                height: 28.0.h,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: ConstantColors.primary,
                                  ),
                                  child: const Text(
                                    'Track',
                                    style: TextStyle(
                                        color: ConstantColors.white,
                                        letterSpacing: 0.75),
                                  ),
                                  onPressed: () {
                                    print(
                                        " Member ID: ${member.id} is been tracked");
                                    // Handle track button press
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: ConstantSizes.defaultSpace.h),
                        child: const Loader(),
                      );
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
                    } else if (state is OrganizationSuccess) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.members.length,
                        itemBuilder: (context, index) {
                          Member member = state.members[index];
                          return Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: ConstantColors.grey,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(
                                  member.username[0],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                member.username,
                                style: const TextStyle(
                                  color: ConstantColors.primary,
                                  fontSize: ConstantSizes.fontSizeLg,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text('Member ID: ${member.id}'),
                              trailing: SizedBox(
                                height: 28.0.h,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: ConstantColors.primary,
                                  ),
                                  child: const Text(
                                    'Status',
                                    style: TextStyle(
                                        color: ConstantColors.white,
                                        letterSpacing: 0.75),
                                  ),
                                  onPressed: () {
                                    print(
                                        " Member ID: ${member.id} is been tracked");
                                    // Handle track button press
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Text(
                          "No Members found in this organization");
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
                    } else if (state is OrganizationSuccess) {
                      if (state.posts.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            Post post = state.posts[index];
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                    color: ConstantColors.grey,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                  title: Text(
                                    post.title,
                                    style: const TextStyle(
                                      color: ConstantColors.primary,
                                      fontSize: ConstantSizes.fontSizeLg,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(post.content),
                                  trailing: SizedBox(
                                    height: 28.0.h,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: ConstantColors.primary,
                                      ),
                                      child: const Text(
                                        'View',
                                        style: TextStyle(
                                            color: ConstantColors.white,
                                            letterSpacing: 0.75),
                                      ),
                                      onPressed: () {
                                        print(
                                            "Post ID: ${post} is been viewed");
                                        // Handle view button press
                                      },
                                    ),
                                  )),
                            );
                          },
                        );
                      } else {
                        return const TabStatus(
                            image: ConstantImages.organizationPostIcon,
                            title: 'No Posts Found',
                            subtitle:
                                'Your organization may have not posted anything yet.');
                      }
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
