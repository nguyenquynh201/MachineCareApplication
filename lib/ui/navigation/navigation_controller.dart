import 'package:machine_care/ui/base/base.dart';

class NavigationController extends BaseController {
  int lastClickBack = 0;
  @override
  void onInit() {
    super.onInit();
    setLoading(false);

  }
}