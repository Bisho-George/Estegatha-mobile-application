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
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class PostsList extends StatefulWidget {
  final Organization organization;
  final List<Post> posts;
  final bool? isAdmin;

  PostsList({
    super.key,
    required this.posts,
    required this.isAdmin,
    required this.organization,
  });

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  void deletePostAtIndex(int index) {
    final postId = widget.posts[index].id!;
    final orgId = widget.organization.id!;
    // Call the delete method on the cubit
    context.read<OrganizationCubit>().deletePost(context, postId, orgId);
    // Remove the post from the local list and update the UI
    setState(() {
      widget.posts.removeAt(index);
    });

    HelperFunctions.showCustomToast(
      context: context,
      title: const Text(
        'Post deleted successfully!',
        style: TextStyle(color: ConstantColors.primary),
      ),
      type: ToastificationType.success,
      position: Alignment.bottomCenter,
      duration: 3,
      icon: const Icon(
        Icons.check_circle_outline_rounded,
        color: ConstantColors.primary,
      ),
      backgroundColor: ConstantColors.secondary,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.posts.isEmpty) {
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
              if (widget.isAdmin!)
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreatePostScreen(
                                  orgId: widget.organization.id!,
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
          if (widget.isAdmin!)
            SettingItem(
                label: "Create Post",
                icon: Icons.create,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreatePostScreen(
                        orgId: widget.organization.id!,
                      ),
                    ),
                  );
                }),
          const SectionHeading(title: "Organization Posts"),
          RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<OrganizationCubit>(context)
                  .getOrganizationPosts(widget.organization.id!);
            },
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.posts.length,
              itemBuilder: (context, index) {
                Post post = widget.posts[index];
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: ConstantColors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(ConstantSizes.sm)),
                    child: ListTile(
                      title: Text(
                        post.title!.length > 15
                            ? "${post.title!.substring(0, 15)}..."
                            : post.title!,
                        style: const TextStyle(
                          color: ConstantColors.primary,
                          fontSize: ConstantSizes.fontSizeLg,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(post.content!.length > 30
                          ? "${post.content!.substring(0, 30)}..."
                          : post.content!),
                      trailing: SizedBox(
                        height: getProportionateScreenHeight(28),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              tooltip: "Read More",
                              icon: const Icon(
                                Icons.read_more,
                                color: ConstantColors.primary,
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
                            if (widget.isAdmin!)
                              IconButton(
                                  onPressed: () => deletePostAtIndex(index),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: ConstantColors.error,
                                  ))
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
