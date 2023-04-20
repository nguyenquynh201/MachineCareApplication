import 'package:flutter/material.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../ui.dart';

class RepairController extends BaseController{
  late RefreshController refreshController;

  @override
  Future<void> onInit()  async{
    super.onInit();
    setLoading(true);
    refreshController = RefreshController();
    await getMaintenanceSchedule();
    setLoading(false);
  }

  int total = 0;
  RxList maintenanceSchedule = [].obs;
  Future getMaintenanceSchedule() async {
    if (total != 0 && total == maintenanceSchedule.length) {
      refreshController.loadComplete();
      return [];
    }
    NetworkState state = await appRepository.getMaintenanceSchedule();
    if(state.isSuccess && state.data != null) {
      if (total == 0) {
        maintenanceSchedule.clear();
      }
      maintenanceSchedule.addAll(state.data);
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
      await getMaintenanceSchedule();
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