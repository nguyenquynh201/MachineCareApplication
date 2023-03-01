import 'dart:io';

import 'package:flutter/material.dart';
import '../../utils/utils.dart';
import '../ui.dart';
class NavigationScreen extends BaseScreen<NavigationController> {
  NavigationScreen({Key? key}) : super(key: key);
  @override
  Widget buildUi({required BuildContext context}) {
    return WillPopScope(child: Scaffold(), onWillPop: () async {
      if (DateTime.now().millisecondsSinceEpoch - controller.lastClickBack < 1000 * 3) {
        exit(0);
      } else {
        controller.lastClickBack = DateTime.now().millisecondsSinceEpoch;
        AppUtils.showToast('msg_info_back_to_close_app'.tr);
      }
      return false;
    });
  }
}