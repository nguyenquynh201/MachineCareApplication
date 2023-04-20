import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductController extends BaseController {
  late RefreshController refreshController;

  @override
  Future<void> onInit()  async{
    super.onInit();
    setLoading(true);
    refreshController = RefreshController();
    await getProduct();
    setLoading(false);
  }

  int total = 0;
  RxList products = [].obs;
  Future getProduct() async {
    if (total != 0 && total == products.length) {
      refreshController.loadComplete();
      return [];
    }
    NetworkState state = await appRepository.getProduct();
    if(state.isSuccess && state.data != null) {
      if (total == 0) {
        products.clear();
      }
      products.addAll(state.data);
      refreshController.loadComplete();
      total = state.total ?? 0;
      print("nè nè $total");
    } else {
      refreshController.loadFailed();
    }
  }
  void onRefresh() async {
    try {
      total = 0;
      await getProduct();
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
    }
  }
  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }

  scrollToTop() {
    refreshController.position?.jumpTo(0);
  }
}
