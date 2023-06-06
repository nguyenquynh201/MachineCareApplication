
import 'package:machine_care/resources/model/product_entity.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/utils/app_utils.dart';

import '../ui.dart';

class ProductDetailController extends BaseController {
  @override
  void onInit() async{
      super.onInit();
      if(Get.arguments != null ) {
        await getProductById(id: (Get.arguments as ProductEntity).sId!);
      }
  }
  Rx<ProductUserEntity> entity = ProductUserEntity().obs;
  Future getProductById({required String id}) async{
    setLoading(true);
    NetworkState state = await appRepository.getProductById(id: id);
    if(state.isSuccess && state.data != null) {
      entity.value = (state.data as ProductUserEntity);
      setLoading(false);
    }else {
      setLoading(false);
      AppUtils.showToast('load_api_fail'.tr);
    }
  }
}