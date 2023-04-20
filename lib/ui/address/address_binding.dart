import 'package:machine_care/ui/address/address.dart';
import 'package:machine_care/ui/ui.dart';

class AddressBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut(() => AddressController());
  }

}