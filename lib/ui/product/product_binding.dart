import 'package:machine_care/ui/ui.dart';

class ProductBinding extends Bindings{
  @override
  void dependencies() {
    Get.put( ProductController());
  }
}