
import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import '../ui.dart';
class NavigationScreen extends BaseScreen<NavigationController> {
  NavigationScreen({Key? key}) : super(key: key);
  @override
  Widget buildUi({required BuildContext context}) {
    return WidgetLoadingFullScreen<NavigationController>(
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: Container(),
      ),
    );
  }
}