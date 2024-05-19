import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/constant/colors.dart';
import '../../view_models/cubit/sos_index_cubit.dart';

class MovingDot extends StatelessWidget {
  final int index;
  final int currentIndex;

  const MovingDot({super.key, required this.index, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SosIndexCubit>().pageController?.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 5),
        width: index == currentIndex ? 20 : 10,
        height: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ConstantColors.primary,
        ),
      ),
    );
  }
}
