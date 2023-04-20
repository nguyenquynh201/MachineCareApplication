
import '../ui.dart';

class CreateEditAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateEditAddressController());
  }

}