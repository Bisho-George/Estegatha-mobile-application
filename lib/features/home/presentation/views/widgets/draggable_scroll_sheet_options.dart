import 'package:estegatha/features/add_place/presentation/views/add_new_boundary.dart';
import 'package:estegatha/features/home/api/role_api.dart';
import 'package:estegatha/features/home/presentation/view_models/current_oragnization_cubit/current_organization_cubit.dart';
import 'package:estegatha/features/home/presentation/views/widgets/organization_option.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../../../utils/helpers/helper_functions.dart';

class DraggableScrollSheetOptions extends StatelessWidget {
  const DraggableScrollSheetOptions({
    super.key,
    required GlobalKey<State<StatefulWidget>> keySection2,
    required GlobalKey<State<StatefulWidget>> keySection3,
  })  : _keySection2 = keySection2,
        _keySection3 = keySection3;

  final GlobalKey<State<StatefulWidget>> _keySection2;
  final GlobalKey<State<StatefulWidget>> _keySection3;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OrganizationOption(
          optionName: 'Add a member',
          iconPath: ConstantImages.peopleIcon,
        ),
        const SizedBox(height: ConstantSizes.spaceBtwItems),
        Text(
          key: _keySection2,
          "Track",
          style: const TextStyle(
            color: ConstantColors.black,
            fontSize: ConstantSizes.fontSizeMd,
            fontWeight: ConstantSizes.fontWeightBold,
          ),
        ),
        const SizedBox(height: ConstantSizes.spaceBtwItems),
        const OrganizationOption(
          optionName: 'Track member',
          iconPath: ConstantImages.wayIcon,
        ),
        const SizedBox(height: ConstantSizes.spaceBtwItems),
        Text(
          key: _keySection3,
          "Boundaries",
          style: const TextStyle(
            color: ConstantColors.black,
            fontSize: ConstantSizes.fontSizeMd,
            fontWeight: ConstantSizes.fontWeightBold,
          ),
        ),
        const SizedBox(height: ConstantSizes.spaceBtwItems),
        GestureDetector(
          onTap: () {
/*            int? orgId = BlocProvider.of<CurrentOrganizationCubit>(context)
                .currentOrganization!
                .id;
            String? role = await RoleApi().getRole(orgId!);*/
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddNewBoundary();
              }));
            /*else {
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

            }*/
          },
          child: const OrganizationOption(
            optionName: 'Manage boundaries',
            iconPath: ConstantImages.buildingIcon,
          ),
        ),
      ],
    );
  }
}
