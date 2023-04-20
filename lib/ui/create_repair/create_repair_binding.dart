import 'package:machine_care/ui/ui.dart';

class CreateRepairBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => CreateRepairController());
  }

}