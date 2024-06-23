import 'package:carousel_slider/carousel_slider.dart';
import 'package:estegatha/utils/constant/colors.dart';

import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';

class SettingCardCarousel extends StatefulWidget {
  final bool isOwner;
  const SettingCardCarousel({super.key, required this.isOwner});

  @override
  _CardCarouselState createState() => _CardCarouselState();
}

class _CardCarouselState extends State<SettingCardCarousel> {
  final List<Map<String, dynamic>> helpNotes = [
    {
      'image': 'assets/org_settings_reg_1.png',
      'title': 'Organization management',
      'text':
          'Changes you make here apply only to the current selected organization.',
    },
    {
      'image': 'assets/org_settings_reg_2.png',
      'title': 'Organization rule',
      'text':
          'Location sharing, places, and tracking apply to a specific organization.',
    },
    // Add more help notes as needed
  ];

  final List<Map<String, dynamic>> ownerHelpNotes = [
    {
      'image': 'assets/org_settings_reg_3.png',
      'title': 'Admin permissions',
      'text':
          'Only admins can edit, delete organization, and change members role.',
    },
    {
      'image': 'assets/org_settings_reg_1.png',
      'title': 'Organization management',
      'text':
          'Changes you make here apply only to the current selected organization.',
    },
    {
      'image': 'assets/org_settings_reg_2.png',
      'title': 'Admin permissions',
      'text':
          'Only admins can edit, delete organization, and change members role.',
    },
    // Add more help notes as needed
  ];

  int _currentImageIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.isOwner ? ownerHelpNotes.length : helpNotes.length,
          options: CarouselOptions(
            height: getProportionateScreenHeight(130),
            enableInfiniteScroll: false,
            autoPlay: false,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentImageIndex = index;
              });
            },
          ),
          carouselController: _carouselController,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        child: Image.asset(
                          widget.isOwner
                              ? ownerHelpNotes[index]['image']
                              : helpNotes[index]['image'],
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    SizedBox(
                        width: getProportionateScreenWidth(ConstantSizes.sm)),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.all(
                            getProportionateScreenHeight(ConstantSizes.sm)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.isOwner
                                  ? ownerHelpNotes[index]['title']
                                  : helpNotes[index]['title'],
                              style: TextStyle(
                                fontSize: SizeConfig.font16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.isOwner
                                  ? ownerHelpNotes[index]['text']
                                  : helpNotes[index]['text'],
                              style: TextStyle(
                                fontSize: SizeConfig.font16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.isOwner ? ownerHelpNotes.length : helpNotes.length,
            (index) => buildDotIndicator(index),
          ),
        ),
      ],
    );
  }

  Widget buildDotIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: _currentImageIndex == index ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color:
            _currentImageIndex == index ? ConstantColors.primary : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
