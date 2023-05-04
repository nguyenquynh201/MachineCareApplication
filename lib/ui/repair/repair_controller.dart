import 'package:flutter/material.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/utils/app_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../utils/utils.dart';
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
  Rx<DateTime> fromDate = DateTime.now().obs;
  Rx<DateTime> toDate = DateTime.now().obs;
  bool _showCalendar = false;

  bool get showCalendar => _showCalendar;

  void updateBoolShowCalendar() {
    if (_showCalendar) {
      _showCalendar = false;
    } else {
      _showCalendar = true;
    }
  }

  RxInt numberOfWeeks = 0.obs;


  void updateNumberOfWeeks(int numberOfWeeks) {
    this.numberOfWeeks.value = numberOfWeeks;
  }

  void updateCurrentDate(DateTime date) {
    AppUtils.logMessage("$date");
    if (DateTimeUtils.isSameDate(fromDate.value, date)) return;
    fromDate.value = date;
    toDate.value = date;
    numberOfWeeks.value = 0;
    getMaintenanceSchedule();
    AppUtils.logMessage("$date");
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