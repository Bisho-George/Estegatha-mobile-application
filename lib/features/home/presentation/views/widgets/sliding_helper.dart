import 'package:flutter/material.dart';

class SlidingHelper extends StatelessWidget {
  const SlidingHelper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 7,
      decoration: BoxDecoration(
        color: Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}