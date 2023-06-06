import 'package:flutter/cupertino.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/routers/app_routes.dart';
import 'package:machine_care/ui/base/base.dart';
import 'package:machine_care/utils/app_pref.dart';
import 'package:machine_care/utils/app_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../ui.dart';

class ProfileController extends BaseController {
  late RefreshController refreshController;

  @override
  void onInit() async {
    super.onInit();
    refreshController = RefreshController();
    await getProfile();
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }

  void logoutAccount() async {
    String? token = await instance.getToken();
    if (token != null) {
      setLoading(true);
      await appRepository.deleteDeviceToken(token: token);
      setLoading(false);
      Get.offAllNamed(Routes.login);
      AppUtils.showToast('Đăng xuất thành công');
    }
  }

  scrollToTop() {
    refreshController.position?.jumpTo(0);
  }
}
