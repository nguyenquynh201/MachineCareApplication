import 'package:get/get.dart';
import 'package:machine_care/ui/information/information_controller.dart';

class InformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InformationController());
  }
}