

import '../ui.dart';

class MainNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainNavigationController());
  }
}