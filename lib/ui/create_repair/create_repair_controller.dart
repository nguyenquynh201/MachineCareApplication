import 'package:flutter/material.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:machine_care/utils/utils.dart';

class CreateRepairController extends BaseController {
  late TextEditingController startDateController;
  late TextEditingController timeOfDayStartController;
  late TextEditingController noteTextController;
  Rx<String> message = ''.obs;
  Rx<String> content = ''.obs;
  @override
  void onInit() {
    super.onInit();
    startDateController = TextEditingController();
    timeOfDayStartController = TextEditingController();
    noteTextController = TextEditingController();
  }

  final ValueNotifier<TargetMachine> _target = ValueNotifier<TargetMachine>(TargetMachine.frequent);
  ValueNotifier<TargetMachine> get target => _target;

  void updateTarget({TargetMachine? state}) {
    if (state == null || state == _target.value) return;
    _target.value = state;
  }

  final RxBool _selectedService = false.obs;
  RxBool get selectedService => _selectedService;

  void updateSelectedService(bool selectedService) {
    _selectedService.value = selectedService;
  }

  final RxInt _moneyService = 250000.obs;
  RxInt get moneyService => _moneyService;

  RxList get productList => Get.find<ProductController>().products;

  ValueNotifier<ProductUserEntity> selected = ValueNotifier<ProductUserEntity>(ProductUserEntity());

  void updateProduct(ProductUserEntity product) {
    selected.value = product;
  }

  ValueNotifier<DateTime> starTime = ValueNotifier<DateTime>(DateTime.now());

  ValueNotifier<TimeOfDay> timeOfDayStart = ValueNotifier<TimeOfDay>(
      TimeOfDay(hour: DateTime.now().toLocal().hour, minute: DateTime.now().toLocal().minute));

  void updateStartDate(DateTime dateTime) {
    starTime.value = dateTime;
    timeOfDayStart.value = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
    _validateTimeNow(starTime.value);
  }

  Rx<CompareTimeState> timeValidateState = (CompareTimeState.none).obs;

  bool _validateTimeNow(DateTime startTime) {
    timeValidateState.value = CompareTimeState.none;
    if (DateTimeUtils.getDate(startTime).millisecondsSinceEpoch <
        DateTimeUtils.getDate(DateTime.now()).millisecondsSinceEpoch) {
      timeValidateState.value = CompareTimeState.invalid;
      return false;
    }
    return true;
  }

  void updateTime(TimeOfDay? time) {
    if (time == null) return;
    starTime.value = DateTime(
      starTime.value.year,
      starTime.value.month,
      starTime.value.day,
      time.hour,
      time.minute,
    );
    timeOfDayStart.value = TimeOfDay(hour: time.hour, minute: time.minute);
    updateStartTimeOfDay(timeOfDayStart.value);
  }

  void updateStartTimeOfDay(TimeOfDay timeOfDay) {
    timeOfDayStart.value = timeOfDay;
    _validateTimeOfDay(timeOfDayStart.value);
  }

  Rx<CompareTimeState> timeOfDayValidateState = (CompareTimeState.none).obs;

  bool _validateTimeOfDay(TimeOfDay start) {
    timeOfDayValidateState.value = CompareTimeState.none;

    /// chưa check minutes
    if (DateTimeUtils.getDate(starTime.value) ==
            DateTime(DateTime.now().toLocal().year, DateTime.now().toLocal().month,
                DateTime.now().toLocal().day) &&
        (DateTimeUtils.getTimeOfDay(start).hour <= TimeOfDay.now().hour &&
            DateTimeUtils.getTimeOfDay(start).minute <= TimeOfDay.now().minute)) {
      timeOfDayValidateState.value = CompareTimeState.invalid;
      return false;
    }

    /// check thời gian chọn có lớn hơn thời gian hiện tại + time của remind
    return true;
  }

  RxList<ErrorMachineEntity> error = <ErrorMachineEntity>[].obs;
  void updateError(List<ErrorMachineEntity> errors) {
    error.value = errors;
  }

  void removeError(ErrorMachineEntity value) {
    error.removeWhere((element) => value.sId == element.sId);
  }

  Rx<bool> get enable {
    return (error.isNotEmpty &&
            timeOfDayValidateState.value == CompareTimeState.none &&
            timeValidateState.value == CompareTimeState.none && productList.isNotEmpty)
        .obs;
  }

  void createRepair() async{
    setLoading(true);
    MaintenanceScheduleEntity _entity = MaintenanceScheduleEntity(
      errorMachine: error,
      products: selected.value.productId,
      maintenanceContent: message.value,
      startDate: starTime.value,
      target: _target.value,
      status: DataFilter.status.first
    );
    try{
      NetworkState state = await appRepository.createRepair(entity: _entity);
      if(state.isSuccess && state.data != null) {
        setLoading(false);
        Get.find<RepairController>().onRefresh();
        Get.back();
        AppUtils.showToast("Tạo lịch sửa chữa thành công!!!");
      }
    }catch(e) {
      setLoading(false);
      AppUtils.showToast("Tạo lịch sửa chữa không công!!!");
    }
  }
}
