import '../ui.dart';
class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());
  }

}