import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../utils/common/styles/text_styles.dart';
import '../../domain/models/landing_featues.dart';

class CustomPageView extends StatefulWidget {
  CustomPageView({super.key, required this.itemBuilder, required this.itemCount, this.pageController, this.height = double.infinity});
  NullableIndexedWidgetBuilder itemBuilder;
  double height;
  int itemCount;
  PageController ?pageController;
  @override
  CustomPageViewState createState() => CustomPageViewState();
}

class CustomPageViewState extends State<CustomPageView> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    PageController pageController = widget.pageController ?? PageController();
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.itemCount,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: widget.itemBuilder,
          ),
        ),
        SizedBox(height: responsiveHeight(10)), // Adjust this value as needed
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.itemCount,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
                pageController.jumpToPage(index);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0), // Adjust this value as needed
                width: 12.0, // Adjust this value as needed
                height: 12.0, // Adjust this value as needed
                decoration: BoxDecoration(
                  color: _currentIndex == index ? ConstantColors.primary : ConstantColors.secondary, // Replace 'Colors.blue' with your primary color
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}