import 'package:flutter/cupertino.dart';
import 'package:machine_care/routers/app_routes.dart';
import 'package:machine_care/ui/base/base.dart';
import 'package:machine_care/utils/app_pref.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../ui.dart';

class ProfileController extends BaseController {
  late RefreshController refreshController;
  @override
  void onInit() async{
    super.onInit();
    refreshController = RefreshController();
    await getProfile();

  }
  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }
  
  void logoutAccount() {
    Get.offAllNamed(Routes.login);
  }
  
  scrollToTop() {
    refreshController.position?.jumpTo(0);
  }
}