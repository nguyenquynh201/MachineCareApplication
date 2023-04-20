import 'package:machine_care/ui/ui.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put( ProfileController());
  }

}