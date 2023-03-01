import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../constants/app_colors.dart';
class ToastOverLay extends StatelessWidget {
  final Widget content;
  const ToastOverLay({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toastTheme = OverlaySupportTheme.toast(context);
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DefaultTextStyle(
          style: TextStyle(color: toastTheme?.textColor),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: const Alignment(0, 0.85),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: AppColor.toastBackgroundColor,
                ),
                child: content,
              ),
            ),
          ),
        ),
      ),
    );
  }
}