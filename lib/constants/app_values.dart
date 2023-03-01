
import 'package:flutter/cupertino.dart';
import 'package:machine_care/ui/ui.dart';

class AppValues {
  AppValues._();

  static double headerHeight = 41.h + Get.mediaQuery.viewPadding.top;
  static double footerHeight = 55.h + Get.mediaQuery.viewPadding.bottom;

  static double originalDesignWidth = 414;
  static double originalDesignHeight = 896;
  static double scale = 1;
  static const String oneSignalID = "7e5a437e-6db5-4645-be8d-877f1b3989c2";
  static scaleSize(BuildContext context) {
    double calculateHeight = originalDesignHeight - (MediaQuery.of(context).viewPadding.bottom == 0 ? 20 : MediaQuery.of(context).viewPadding.bottom) - MediaQuery.of(context).viewPadding.top;

    double scaleWidth = Get.width / (originalDesignWidth - MediaQuery.of(context).viewPadding.left);
    double scaleHeight =
        (Get.height - MediaQuery.of(context).viewPadding.bottom - MediaQuery.of(context).viewPadding.top) /
            calculateHeight;
    if (Get.width > 650) {
      scale = scaleWidth < scaleHeight ? scaleWidth : scaleHeight;
    } else {
      scale = scaleWidth > scaleHeight ? scaleWidth : scaleHeight;
    }
  }
}