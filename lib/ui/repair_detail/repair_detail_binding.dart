
import 'package:machine_care/ui/ui.dart';

class RepairDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RepairDetailController());
  }

}