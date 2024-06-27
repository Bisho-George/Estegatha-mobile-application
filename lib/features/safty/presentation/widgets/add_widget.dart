import 'package:flutter/material.dart';

import '../../../../utils/constant/colors.dart';
class AddWidget extends StatelessWidget {
  const AddWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 16,
      backgroundColor: ConstantColors.primary,
      child: Icon(
        Icons.add,
        color: ConstantColors.white,
      ),
    );
  }
}