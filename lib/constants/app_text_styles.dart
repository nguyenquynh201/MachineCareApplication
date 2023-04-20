
import 'package:flutter/cupertino.dart';
import 'package:machine_care/ui/ui.dart';

import 'constants.dart';
const fontSizeVerySmall = 10.0;
const fontSizeSmall = 12.0;
const fontSizeMedium = 14.0;
const fontSizeLarge = 16.0;
const fontSizeSuperLarge = 20.0;
const fontSizeSuperHeroLarge = 24.0;

const textHeightNormal = 1.2;
const textHeightMedium = 1.0;
const textHeightSuperLarge = 2.0;
class AppTextStyles {

  AppTextStyles._();

  static bool isTablet() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide >= 600 ? true : false;
  }
  static double _getFontSize(double size) => size.sp;

  static double _getHeight(double size) => size.h;

  static TextStyle verySmall() {
    if (isTablet()) {
      return const TextStyle(
        fontSize: fontSizeVerySmall,
        height: 1.0,
        color: AppColor.black,
        fontWeight: FontWeight.w400,
      );
    } else {
      return TextStyle(
        fontSize: _getFontSize(fontSizeVerySmall),
        height: _getHeight(textHeightNormal),
        color: AppColor.black,
      );
    }
  }

  static TextStyle verySmallBold() {
    if (isTablet()) {
      return const TextStyle(
        fontSize: fontSizeVerySmall,
        fontWeight: FontWeight.w600,
        height: 1.0,
        color: AppColor.black,
      );
    } else {
      return TextStyle(
        fontSize: _getFontSize(fontSizeVerySmall),
        fontWeight: FontWeight.w600,
        height: _getHeight(textHeightNormal),
        color: AppColor.black,
      );
    }
  }

  static TextStyle small() {
    if (isTablet()) {
      return const TextStyle(
        fontSize: fontSizeSmall,
        height: 1.0,
        color: AppColor.black,
        fontWeight: FontWeight.w400,
      );
    } else {
      return TextStyle(
        fontSize: _getFontSize(fontSizeSmall),
        height: _getHeight(textHeightNormal),
        color: AppColor.black,
      );
    }
  }

  static TextStyle smallBold() {
    if (isTablet()) {
      return const TextStyle(
        fontSize: fontSizeSmall,
        fontWeight: FontWeight.w600,
        height: 1.0,
        color: AppColor.black,
      );
    } else {
      return TextStyle(
        fontSize: _getFontSize(fontSizeSmall),
        fontWeight: FontWeight.w600,
        height: _getHeight(textHeightNormal),
        color: AppColor.black,
      );
    }
  }

  static TextStyle medium() {
    if (isTablet()) {
      return const TextStyle(
          fontSize: fontSizeMedium,
          height: 1.0,
          color: AppColor.black,
          fontWeight: FontWeight.w400);
    } else {
      return TextStyle(
        fontSize: _getFontSize(fontSizeMedium),
        height: _getHeight(textHeightNormal),
        color: AppColor.black,
      );
    }
  }
  static TextStyle customTextStyle() {
    return const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: fontSizeMedium,
      height: 1.0,
      color: AppColor.white,
    );
  }
  static TextStyle largeBold() {
    if (isTablet()) {
      return const TextStyle(
        fontSize: fontSizeLarge,
        fontWeight: FontWeight.w600,
        height: 1.0,
        color: AppColor.black,
      );
    } else {
      return TextStyle(
        fontSize: _getFontSize(fontSizeLarge),
        fontWeight: FontWeight.w600,
        height: _getHeight(textHeightNormal),
        color: AppColor.black,
      );
    }
  }
  static TextStyle superLarge() {
    if (isTablet()) {
      return const TextStyle(
        fontSize: fontSizeSuperLarge,
        height: 1.0,
        //fontFamily: FONT_FAMILY,
        fontWeight: FontWeight.w400,
        color: AppColor.black,
      );
    } else {
      return TextStyle(
        fontSize: _getFontSize(fontSizeSuperLarge),
        height: _getHeight(textHeightNormal),
        //fontFamily: FONT_FAMILY,
        color: AppColor.black,
      );
    }
  }

  static TextStyle superLargeBold() {
    if (isTablet()) {
      return const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: fontSizeSuperLarge,
        height: 1.0,
        color: AppColor.black,
      );
    } else {
      return TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: _getFontSize(fontSizeSuperLarge),
        height: _getHeight(textHeightNormal),
        color: AppColor.black,
      );
    }
  }
}