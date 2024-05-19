import 'package:flutter/material.dart';

import '../../../../../utils/constant/colors.dart';

class MovingDot extends StatelessWidget {
  final int index;
  final int currentIndex;

  const MovingDot({super.key, required this.index, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      width: index == currentIndex ? 20 : 10,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ConstantColors.primary,
      ),
    );
  }
}
