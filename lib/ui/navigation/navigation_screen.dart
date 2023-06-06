import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import '../ui.dart';

class NavigationScreen extends BaseScreen<NavigationController> {
  NavigationScreen({Key? key}) : super(key: key);

  @override
  Widget buildUi({required BuildContext context}) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Center(
              child: WidgetImageAsset(
            url: AppImages.icApp,
            fit: BoxFit.contain,
          ))
        ],
      ),
    );
  }
}
