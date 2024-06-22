import 'package:estegatha/features/organization/domain/models/post.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/organization_tab_status.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostsList extends StatelessWidget {
  final List<Post> posts;

  const PostsList({required this.posts});

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return const TabStatus(
          image: ConstantImages.organizationPostIcon,
          title: 'No Posts Found',
          subtitle: 'Your organization may have not posted anything yet.');
    }

    return ListView.builder(
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
                        color: ConstantColors.white, letterSpacing: 0.75),
                  ),
                  onPressed: () {
                    print("Post ID: ${post.id} is being viewed");
                    // Handle view button press
                  },
                ),
              )),
        );
      },
    );
  }
}
