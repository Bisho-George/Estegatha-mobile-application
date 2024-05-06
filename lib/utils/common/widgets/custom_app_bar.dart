import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../styles/text_styles.dart';
class CustomAppBar {
  static AppBar buildAppBar(String title) {
    return AppBar(
      elevation: 0,
      backgroundColor: ConstantColors.white,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x19000000),
                offset: Offset(0, 1.50),
                spreadRadius: 0,
              )
            ],
          ),
        ),
      ),
      title: Text(
          title,
          style: Styles.getDefaultPrimary()
      ),
    );
  }
}
