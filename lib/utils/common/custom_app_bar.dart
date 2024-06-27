import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.showBackArrow = true,
    this.leadingOnPressed,
  });

  final Widget? title;
  final List<Widget>? actions;
  final IconData? leadingIcon;
  final bool showBackArrow;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return PreferredSize(
      preferredSize: Size.fromHeight(
        getProportionateScreenHeight(ConstantSizes.appBarHeight),
      ),
      child: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: ConstantColors.white,
            boxShadow: [
              BoxShadow(
                color: ConstantColors.grey,
                blurRadius: 5.0,
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                icon: const Icon(
                  Iconsax.arrow_left,
                  color: ConstantColors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            : leadingIcon != null
                ? IconButton(
                    icon: Icon(
                      leadingIcon,
                      color: ConstantColors.textPrimary,
                    ),
                    onPressed: leadingOnPressed,
                  )
                : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(getProportionateScreenHeight(ConstantSizes.appBarHeight));
}
