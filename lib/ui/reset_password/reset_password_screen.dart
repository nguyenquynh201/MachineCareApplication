import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';

import '../ui.dart';
class ResetPasswordScreen extends BaseScreen<ResetPasswordController> {
  ResetPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return WidgetLoadingFullScreen<ResetPasswordController>(
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: Container(),
      ),
    );
  }
}