import 'package:get/get.dart';

class BaseController extends GetxController{
  @override
  void onInit() {
    super.onInit();
    setLoading(false);
  }

  @override
  void onClose() {
    super.onClose();
    setLoading(false);
  }

  var loading = false.obs;

  setLoading(bool status) => loading.value = status;


}