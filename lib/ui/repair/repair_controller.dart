import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../utils/utils.dart';
import '../ui.dart';

class  RepairController extends BaseController {
  RefreshController refreshController = RefreshController();

  @override
  Future<void> onInit() async {
    super.onInit();
    setLoading(true);
     getAllMaintenanceSchedule();
    await getMaintenanceSchedule();
    setLoading(false);
  }

  Rx<DateTime> fromDate = DateTime.now().obs;
  Rx<DateTime> toDate = DateTime.now().obs;
  final Rx<bool> _showCalendar = false.obs;

  Rx<bool> get showCalendar => _showCalendar;

  void updateBoolShowCalendar() {
    if (_showCalendar.value) {
      _showCalendar.value = false;
    } else {
      _showCalendar.value = true;
    }
  }

  RxInt numberOfWeeks = 0.obs;

  void updateNumberOfWeeks(int numberOfWeeks) {
    this.numberOfWeeks.value = numberOfWeeks;
  }

  void updateCurrentDate(DateTime date) async {
    AppUtils.logMessage("$date");
    AppUtils.logMessage("${DateTimeUtils.isSameDate(fromDate.value, date)}");
    if (DateTimeUtils.isSameDate(fromDate.value, date)) {
      return;
    }
    fromDate.value = date;
    toDate.value = date;
    numberOfWeeks.value = 0;
    await getMaintenanceSchedule(isLoading: true);
    AppUtils.logMessage("$date");
  }

  int total = 0;
  List<MaintenanceScheduleEntity> allMaintenanceSchedule = List.from([]);
  RxList<MaintenanceScheduleEntity> maintenanceSchedule = <MaintenanceScheduleEntity>[].obs;

  void getAllMaintenanceSchedule() async {
    NetworkState state = await appRepository.getMaintenanceSchedule(limit: 0, offset: 0);
    if (state.isSuccess && state.data != null) {
      allMaintenanceSchedule = state.data;
    }
  }

  Future getMaintenanceSchedule({bool isLoading = false}) async {
    if (!isLoading) {
      if (total != 0 && total == maintenanceSchedule.length) {
        refreshController.loadComplete();
        return [];
      }
    }
    NetworkState state = await appRepository.getMaintenanceSchedule(
        offset: 0,
        limit: EndPoint.LIMIT,
        from: fromDate.value,
        to: toDate.value);
    if (state.isSuccess && state.data != null) {
      if (total == 0) {
        maintenanceSchedule.clear();
      }
      if (isLoading) {
        maintenanceSchedule.value = state.data;
      } else {
        maintenanceSchedule.addAll(state.data);
      }
      refreshController.loadComplete();
      total = state.total ?? 0;
      print("nè nè ${maintenanceSchedule.length}");
    } else {
      refreshController.loadFailed();
    }
  }

  void onRefresh() async {
    try {
      total = 0;
      getAllMaintenanceSchedule();
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
