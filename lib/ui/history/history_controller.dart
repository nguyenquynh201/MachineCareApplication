import 'package:machine_care/ui/base/base.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HistoryController extends BaseController {
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