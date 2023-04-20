import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/ui/information/information_controller.dart';
import 'package:flutter/material.dart';
import '../ui.dart';

class InformationScreen extends BaseScreen<InformationController> {
  InformationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return WidgetLoadingFullScreen<InformationController>(
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: Container(),
      ),
    );
  }
}