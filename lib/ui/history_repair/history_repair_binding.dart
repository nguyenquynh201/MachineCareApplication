import '../ui.dart';

class HistoryRepairBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryRepairController());
  }
}
