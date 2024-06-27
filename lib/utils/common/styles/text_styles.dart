import 'dart:ui';

import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
class _WhiteTextStyle extends TextStyle{
  const _WhiteTextStyle({super.fontSize, super.fontWeight}): super(
    color: ConstantColors.textWhite,
    fontFamily: 'Poppins',
    height: 0,
  );
}

class _PrimaryTextStyle extends TextStyle{
  const _PrimaryTextStyle({super.fontSize, super.fontWeight}): super(
    color: ConstantColors.textPrimary,
    fontFamily: 'Poppins',
    height: 0,
  );
}

class _SecondaryTextStyle extends TextStyle{
  const _SecondaryTextStyle({super.fontSize, super.fontWeight}): super(
    color: ConstantColors.textSecondary,
    fontFamily: 'Poppins',
    height: 0,
  );
}

class Styles{
  static TextStyle getWhiteLarge() => const _WhiteTextStyle(
      fontSize: ConstantSizes.headingLg,
      fontWeight: ConstantSizes.fontWeightExtraBold
  );
  static TextStyle getWhiteMedium()=> const _WhiteTextStyle(
      fontSize: ConstantSizes.headingMd,
      fontWeight: ConstantSizes.fontWeightSemiBold
  );
  static TextStyle getDefaultWhite(
      {
        double fontSize = ConstantSizes.headingSm,
        FontWeight weight = ConstantSizes.fontWeightRegular
      })=> _WhiteTextStyle(
      fontSize: fontSize,
      fontWeight: weight
  );
  static TextStyle getPrimaryLarge()=> const _PrimaryTextStyle(
      fontSize: ConstantSizes.headingLg,
      fontWeight: ConstantSizes.fontWeightExtraBold
  );
  static TextStyle getPrimaryMedium()=> const _PrimaryTextStyle(
      fontSize: ConstantSizes.headingMd,
      fontWeight: ConstantSizes.fontWeightSemiBold
  );
  static TextStyle getDefaultPrimary(
      {
        double fontSize = ConstantSizes.headingSm,
        FontWeight weight = ConstantSizes.fontWeightRegular
      })=> _PrimaryTextStyle(
      fontSize: fontSize,
      fontWeight: weight
  );
  static TextStyle getSecondaryLarge()=> const _SecondaryTextStyle(
      fontSize: ConstantSizes.headingLg,
      fontWeight: ConstantSizes.fontWeightExtraBold
  );
  static TextStyle getSecondaryMedium()=> const _SecondaryTextStyle(
      fontSize: ConstantSizes.headingMd,
      fontWeight: ConstantSizes.fontWeightSemiBold
  );
  static TextStyle getDefaultSecondary(
      {
        double fontSize = ConstantSizes.headingSm,
        FontWeight weight = ConstantSizes.fontWeightRegular
      })=> _SecondaryTextStyle(
      fontSize: fontSize,
      fontWeight: weight
  );
}