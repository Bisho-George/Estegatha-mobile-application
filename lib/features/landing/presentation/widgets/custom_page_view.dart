import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../utils/common/styles/text_styles.dart';
import '../../domain/models/landing_featues.dart';

class CustomPageView extends StatefulWidget {
  CustomPageView({super.key, required this.itemBuilder, required this.itemCount, this.pageController, this.height = double.infinity, this.pagesInfo});
  NullableIndexedWidgetBuilder itemBuilder;
  double height;
  int itemCount;
  PageController ?pageController;
  PagesInfo ?pagesInfo;
  @override
  CustomPageViewState createState() => CustomPageViewState();
}
class PagesInfo{
  int currentIndex = 0;
  late int itemCount;
  PagesInfo();
  bool get isLastPage => currentIndex == itemCount - 1;
}
class CustomPageViewState extends State<CustomPageView> {
  @override
  Widget build(BuildContext context) {
    PageController pageController = widget.pageController ?? PageController();
    PagesInfo pagesInfo = widget.pagesInfo ?? PagesInfo();
    pagesInfo.itemCount = widget.itemCount;
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.itemCount,
            onPageChanged: (index) {
              setState(() {
                pagesInfo.currentIndex = index;
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
                  pagesInfo.currentIndex = index;
                });
                pageController.jumpToPage(index);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0), // Adjust this value as needed
                width: 12.0, // Adjust this value as needed
                height: 12.0, // Adjust this value as needed
                decoration: BoxDecoration(
                  color: pagesInfo.currentIndex == index ? ConstantColors.primary : ConstantColors.secondary, // Replace 'Colors.blue' with your primary color
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