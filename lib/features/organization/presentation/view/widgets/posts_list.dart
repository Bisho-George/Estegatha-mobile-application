import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/domain/models/post.dart';
import 'package:estegatha/features/organization/presentation/view/create/creat_post_screen.dart';
import 'package:estegatha/features/organization/presentation/view/main/post_detail_screen.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/organization_tab_status.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/features/settings/presentation/view/widgets/setting_item.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostsList extends StatelessWidget {
  Organization organization;
  final List<Post> posts;
  bool? isAdmin = false;

  PostsList(
      {super.key,
      required this.posts,
      required this.isAdmin,
      required this.organization});

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return TabStatus(
          image: ConstantImages.organizationPostIcon,
          title: 'No Posts Found',
          subtitle: Column(
            children: [
              const Text('Your organization may have not posted anything yet.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstantColors.darkGrey,
                    fontSize: ConstantSizes.fontSizeSm,
                  )),
              SizedBox(height: getProportionateScreenHeight(ConstantSizes.md)),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreatePostScreen(
                                orgId: organization.id!,
                              )));
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: ConstantColors.grey),
                ),
                child: Text(
                  'Create Post',
                  style: TextStyle(
                      color: ConstantColors.primary,
                      fontSize: SizeConfig.font14),
                ),
              )
            ],
          ));
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: ConstantSizes.bottomNavBarHeight),
      child: Column(
        children: [
          if (isAdmin!)
            SettingItem(
                label: "Create Post",
                icon: Icons.create,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreatePostScreen(
                        orgId: organization.id!,
                      ),
                    ),
                  );
                }),
          const SectionHeading(title: "Organization Posts"),
          RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<OrganizationCubit>(context)
                  .getOrganizationPosts(organization.id!);
            },
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                Post post = posts[index];
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
                        post.title!,
                        style: const TextStyle(
                          color: ConstantColors.primary,
                          fontSize: ConstantSizes.fontSizeLg,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(post.content!.length > 40
                          ? "${post.content!.substring(0, 40)}..."
                          : post.content!),
                      trailing: SizedBox(
                        height: getProportionateScreenHeight(28),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostDetailScreen(
                                  post: post,
                                ),
                              ),
                            );
                          },
                        ),
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
