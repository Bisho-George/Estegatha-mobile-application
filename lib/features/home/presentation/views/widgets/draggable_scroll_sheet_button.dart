import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/constant/colors.dart';

class DraggableScrollSheetButton extends StatelessWidget {
  double opacity;
  bool isSelected;
  String iconPath;

  DraggableScrollSheetButton(
      {required this.opacity,
      required this.isSelected,
      required this.iconPath,
      required this.onPressed});

  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        color: isSelected ? ConstantColors.primary.withOpacity(.89) :  ConstantColors.primaryBackground,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Opacity(
        opacity: opacity,
        child: IconButton(
          icon: SvgPicture.asset(
            iconPath,
            height: 18,
            color: isSelected ? Colors.white : ConstantColors.primary,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
