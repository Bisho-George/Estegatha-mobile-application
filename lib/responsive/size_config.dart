import 'package:flutter/cupertino.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    // print(_mediaQueryData.size.width);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double responsiveHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 892.0) * screenHeight;
}

// Get the proportionate height as per screen size
double responsiveWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 412.0) * screenWidth;
}

/*
double f16(){
  return SizeConfig.screenHeight/52.75;
}
double f20(){
  return SizeConfig.screenHeight/42.2;
}
double f26(){
  return SizeConfig.screenHeight/32.3;
}
double r15(){
  return SizeConfig.screenHeight/56.27;
}
double r20(){
  return SizeConfig.screenHeight/42.2;
}
double r30(){
  return SizeConfig.screenHeight/28.13;
}
double i30(){
  return SizeConfig.screenHeight/28;
}
double i24(){
  return SizeConfig.screenHeight/35.17;
}
double i20(){
  return SizeConfig.screenHeight/42;
}
double i16(){
  return SizeConfig.screenHeight/52.75;
}*/
