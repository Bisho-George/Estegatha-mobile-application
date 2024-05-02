import 'package:flutter/material.dart';

import '../../../../utils/common/styles/text_styles.dart';
import '../../../../utils/constant/sizes.dart';
class CancelAlertButton extends StatelessWidget {
  CancelAlertButton({super.key, required this.onTap});
  void Function () onTap;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 150,
      backgroundColor: Colors.white.withOpacity(0.1),
      child: CircleAvatar(
        radius: 100,
        backgroundColor: Colors.white.withOpacity(0.2),
        child: GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white,
            child: Container(
              width: 74,
              height: 90,
              alignment: Alignment.center,
              child: Text(
                'Cancel Alert',
                textAlign: TextAlign.center,
                style: Styles.getDefaultPrimary(
                  weight: ConstantSizes.fontWeightBold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}