import 'package:machine_care/resources/network_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../ui.dart';

class AddressController extends BaseController {
  late RefreshController refreshController;

  @override
  void onInit() async {
    super.onInit();
    setLoading(true);
    refreshController = RefreshController();
    await getAddress();
    setLoading(false);
  }

  int total = 0;
  RxList address = [].obs;

  Future getAddress() async {
    if (total != 0 && total == address.length) {
      refreshController.loadComplete();
      return [];
    }
    NetworkState state = await appRepository.getAddress();
    if (state.isSuccess && state.data != null) {
      if (total == 0) {
        address.clear();
      }
      address.addAll(state.data);
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
      await getAddress();
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
}
