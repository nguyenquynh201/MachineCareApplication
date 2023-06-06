import 'package:machine_care/ui/ui.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ProductDetailController());
  }

}