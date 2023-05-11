import 'package:machine_care/ui/ui.dart';

class EditRepairBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => EditRepairController());
  }

}