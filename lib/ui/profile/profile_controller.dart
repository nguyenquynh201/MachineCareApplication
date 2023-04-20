import 'package:machine_care/ui/base/base.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  scrollToTop() {
    refreshController.position?.jumpTo(0);
  }
}