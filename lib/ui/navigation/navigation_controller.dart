import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/scheduler.dart';
import 'package:machine_care/routers/app_routes.dart';
import 'package:machine_care/utils/app_pref.dart';
import '../ui.dart';

class NavigationController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    setLoading(false);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _initialLaunchApp();
    });
    setLoading(true);
  }
  Future _initialLaunchApp() async {

    appRepository.isUserLoggedIn().then((isLoggedIn) async {
      if (isLoggedIn) {
        Get.toNamed(Routes.mainNavigation);
      }else {
        Get.toNamed(Routes.login);
      }
    });
  }
}