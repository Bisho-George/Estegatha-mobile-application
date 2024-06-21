import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../../constant/image_strings.dart';

class BottomNavBarFAB extends StatelessWidget {
  const BottomNavBarFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ConstantColors.primary,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: ConstantColors.secondaryBackground
                .withOpacity(0.5),
            spreadRadius: 10,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: FloatingActionButton(
        clipBehavior: Clip.none,
        backgroundColor: ConstantColors.secondaryBackground,
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Image.asset(ConstantImages.organizationIcon),
      ),
    );
  }
}
