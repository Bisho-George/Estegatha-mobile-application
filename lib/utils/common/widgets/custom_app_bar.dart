import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../styles/text_styles.dart';
class CustomAppBar {
  static AppBar buildAppBar({required String title, List<Widget> actions = const []}) {
    return AppBar(
      actions: actions,
      backgroundColor: ConstantColors.white,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFEDEDED),
                width: 1,
              ),
            ),
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
