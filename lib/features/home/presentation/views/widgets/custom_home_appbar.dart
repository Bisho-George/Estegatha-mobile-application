import 'package:estegatha/features/home/presentation/view_models/current_oragnization_cubit/current_organization_cubit.dart';
import 'package:estegatha/features/home/presentation/views/widgets/animated_organization_header.dart';
import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/presentation/view/setting/organization_settings_screen.dart';
import 'package:estegatha/features/settings/presentation/view/settings_screen.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Organization? currentOrganization =
        context.read<CurrentOrganizationCubit>().currentOrganization;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        decoration: BoxDecoration(
          color: ConstantColors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: IconButton(
          icon: SvgPicture.asset(ConstantImages.settingsAppbarIcon),
          onPressed: () {
            PersistentNavBarNavigator.pushNewScreen(context,
                screen: OrganizationSettingsScreen(
                    organizationId: currentOrganization!.id!),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.scale);
          },
        ),
      ),
      SizedBox(width: getProportionateScreenWidth(ConstantSizes.md)),
      Expanded(
        flex: 2,
        child: AnimatedOrganizationHeader(
          isExpanded: false,
        ),
      ),
      // Container(
      //   decoration: BoxDecoration(
      //     color: ConstantColors.white,
      //     borderRadius: BorderRadius.circular(50),
      //   ),
      //   child: IconButton(
      //     onPressed: () {},
      //     icon: SvgPicture.asset(ConstantImages.messagesIcon),
      //   ),
      // )
    ]);
  }
}
