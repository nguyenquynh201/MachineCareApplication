
import 'package:flutter/cupertino.dart';

import 'constants.dart';
const fontSizeVerySmall = 10.0;
const fontSizeSmall = 12.0;
const fontSizeMedium = 14.0;
const fontSizeLarge = 16.0;
const fontSizeSuperLarge = 20.0;

const textHeightNormal = 1.2;
const textHeightMedium = 1.0;
const textHeightSuperLarge = 2.0;
class AppTextStyles {

  AppTextStyles._();
  static TextStyle customTextStyle() {
    return const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: fontSizeMedium,
      height: 1.0,
      color: AppColor.white,
    );
  }

}