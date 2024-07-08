// import 'package:estegatha/utils/common/custom_app_bar.dart';
// import 'package:estegatha/utils/constant/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:estegatha/utils/helpers/responsive.dart';

// class CreatePostScreen extends StatelessWidget {
//   const CreatePostScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       appBar: CustomAppBar(
//         leadingIcon: Icons.arrow_back,
//         leadingOnPressed: () {
//           Navigator.pop(context, true);
//         },
//         title: Text(
//           "Create Post",
//           style: TextStyle(
//             fontSize: SizeConfig.font20,
//             color: ConstantColors.primary,
//           ),
//         ),
//         showBackArrow: false,
//       ),
//       body: Center(
//         child: Text('Create Post Screen'),
//       ),
//     );
//   }
// }

import 'package:estegatha/features/organization/presentation/view/main/organization_detail_page.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_state.dart';
import 'package:estegatha/utils/common/custom_app_bar.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/common/widgets/custom_text_field.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class CreatePostScreen extends StatefulWidget {
  int orgId;
  CreatePostScreen({super.key, required this.orgId});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: Icons.arrow_back,
        leadingOnPressed: () {
          Navigator.pop(context, true);
        },
        title: Text(
          "Create Post",
          style: TextStyle(
            fontSize: SizeConfig.font20,
            color: ConstantColors.primary,
          ),
        ),
        showBackArrow: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: _titleController,
                labelText: 'Title',
                hintText: 'Enter the title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: getProportionateScreenHeight(ConstantSizes.md)),
              CustomTextField(
                controller: _contentController,
                labelText: 'Content',
                hintText: 'Enter the content',
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              ),
              SizedBox(height: getProportionateScreenHeight(ConstantSizes.md)),
              BlocConsumer<OrganizationCubit, OrganizationState>(
                listener: (context, state) {
                  if (state is CreatePostLoading) {
                    const Loader();
                  } else if (state is CreatePostSuccess) {
                    HelperFunctions.showCustomToast(
                      context: context,
                      title: const Text(
                        'Post created successfully',
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
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(
                    //       content: Text('Post created successfully!')),
                    // );
                    context
                        .read<OrganizationCubit>()
                        .getOrganizationPosts(widget.orgId);
                    Navigator.pop(context);
                  } else if (state is CreatePostFailure) {
                    HelperFunctions.showCustomToast(
                      context: context,
                      title: const Text(
                        'Failed to create post!',
                        style: TextStyle(color: ConstantColors.primary),
                      ),
                      type: ToastificationType.error,
                      position: Alignment.bottomCenter,
                      duration: 3,
                      icon: const Icon(
                        Icons.error_outline_rounded,
                        color: ConstantColors.primary,
                      ),
                      backgroundColor: ConstantColors.secondary,
                    );
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final String title = _titleController.text;
                        final String content = _contentController.text;
                        final int orgId = widget.orgId;
                        context
                            .read<OrganizationCubit>()
                            .createPost(context, title, content, orgId);
                      }
                    },
                    labelText: 'Create Post',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
