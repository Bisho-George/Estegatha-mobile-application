import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/material.dart';

import '../../../../utils/common/styles/text_styles.dart';
import '../../domain/models/landing_featues.dart';

class CustomPageView extends StatefulWidget {
  @override
  _CustomPageViewState createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 32.0), // Adjust this value as needed
          height: 100.0, // Adjust this value as needed
          child: PageView.builder(
            controller: _pageController,
            itemCount: Features.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Text(
                Features.feature(index),
                style: Styles.getPrimaryMedium(),
                textAlign: TextAlign.center,
              );
            },
          ),
        ),
        SizedBox(height: 10.0), // Adjust this value as needed
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            Features.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
                _pageController.jumpToPage(index);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0), // Adjust this value as needed
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