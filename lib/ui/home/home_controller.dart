import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../ui.dart';

class HomeController extends BaseController{
  late RefreshController refreshController;
  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController();
  }
  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }

  scrollToTop() {
    refreshController.position?.jumpTo(0);
  }
}