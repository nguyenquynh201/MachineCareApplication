import 'package:machine_care/resources/network_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../ui.dart';

class AddressController extends BaseController {
   RefreshController refreshController = RefreshController();

  @override
  void onInit() async {
    super.onInit();
    setLoading(true);
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
      (state.data as List<UserAddress>).sort((a , b) => (b.fixed ?? false) ? 1 : -1);
      address.addAll(state.data);
      refreshController.loadComplete();
      total = state.total ?? 0;
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
