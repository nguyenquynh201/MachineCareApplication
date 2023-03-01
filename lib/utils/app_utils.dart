import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:overlay_support/overlay_support.dart';

import '../constants/constants.dart';
import '../ui/ui.dart';

class AppUtils {
  static logMessage(String message) {
    log(message);
  }
  static showToast(String message,
      {Duration duration = const Duration(seconds: 2), BuildContext? context}) {
    if (duration <= Duration.zero) {
      //fast fail
      return;
    }

    showOverlay(
          (context, t) {
        return Opacity(
            opacity: t,
            child: ToastOverLay(
                content: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.customTextStyle().copyWith(
                    color: AppColor.toastTextColor,
                  ),
                )));
      },
      curve: Curves.ease,
      key: const ValueKey('overlay_toast'),
      duration: duration,
      context: context,
    );
  }
}