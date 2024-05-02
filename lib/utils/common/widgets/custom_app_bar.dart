import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../styles/text_styles.dart';
class CustomAppBar {
  static AppBar buildAppBar(String title) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          color: ConstantColors.primary,
          height: 1,
        ),
      ),
      title: Text(
          title,
          style: Styles.getDefaultPrimary()
      ),
    );
  }
}
