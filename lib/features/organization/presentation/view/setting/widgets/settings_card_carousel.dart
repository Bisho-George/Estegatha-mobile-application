import 'package:carousel_slider/carousel_slider.dart';
import 'package:estegatha/utils/constant/colors.dart';

import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/constant/variables.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';

class SettingCardCarousel extends StatefulWidget {
  final List<Map<String, dynamic>> helpNotes;

  const SettingCardCarousel({super.key, required this.helpNotes});

  @override
  _CardCarouselState createState() => _CardCarouselState();
}

class _CardCarouselState extends State<SettingCardCarousel> {
  int _currentImageIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(ConstantSizes.sm)),
      color: ConstantColors.lightContainer,
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: widget.helpNotes.length,
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
                            widget.helpNotes[index]['image'],
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
                                widget.helpNotes[index]['title'],
                                style: TextStyle(
                                  fontSize: SizeConfig.font16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.helpNotes[index]['text'],
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
              widget.helpNotes.length,
              (index) => buildDotIndicator(index),
            ),
          ),
        ],
      ),
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
