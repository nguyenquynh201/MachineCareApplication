import 'package:machine_care/ui/ui.dart';

class NotificationDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationDetailController());
  }
}
