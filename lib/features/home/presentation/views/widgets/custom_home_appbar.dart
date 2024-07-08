import 'package:estegatha/features/home/presentation/views/widgets/animated_organization_header.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        decoration: BoxDecoration(
          color: ConstantColors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: IconButton(
          icon: SvgPicture.asset(ConstantImages.settingsAppbarIcon),
          onPressed: () {},
        ),
      ),
      AnimatedOrganizationHeader(
        isExpanded: false,
      ),
      Container(
          decoration: BoxDecoration(
            color: ConstantColors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(ConstantImages.messagesIcon)))
    ]);
  }
}
