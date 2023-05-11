import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../ui.dart';

class HistoryRepairController extends BaseController {
  RefreshController refreshController = RefreshController();

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      await getHistory();
    }
  }
  int total = 0;
  RxList history = [].obs;
  void onRefresh() async {
    try {
      total = 0;
      await getHistory();
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
    }
  }
  Future getHistory() async {
    if (total != 0 && total == history.length) {
      refreshController.loadComplete();
      return [];
    }
    NetworkState state = await appRepository.getHistory(id: (Get.arguments as MaintenanceScheduleEntity).sId.toString());
    if (state.isSuccess && state.data != null) {
      if (total == 0) {
        history.clear();
      }
      history.addAll(state.data);
      refreshController.loadComplete();
      total = state.total ?? 0;
      print("nè nè $total");
    } else {
      refreshController.loadFailed();
    }
  }
  Map<DateTime, List<HistoryRepairEntity>> get groupedHistories {
    Map<DateTime, List<HistoryRepairEntity>> historiesGroups = {};

    for (var history in history) {
      DateTime key = DateTimeUtils.getDate(history.createdAt);

      bool hasContains = historiesGroups.containsKey(key);
      if (!hasContains) {
        historiesGroups[key] = [];
      }
      historiesGroups[key]!.add(history);
    }

    return historiesGroups;
  }
}
