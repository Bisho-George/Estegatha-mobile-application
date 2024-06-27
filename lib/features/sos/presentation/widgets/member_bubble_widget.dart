import 'package:flutter/material.dart';

import '../../../../utils/common/styles/text_styles.dart';
import '../../../../utils/constant/colors.dart';
class MemberBubbleWidget extends StatelessWidget {
  MemberBubbleWidget({
    super.key,
    required this.name,
  });
  String? name;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: ConstantColors.primary,
      child: Text(
        name![0],
        style: Styles.getDefaultWhite(),
      ),
    );
  }
}