import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/model/product_entity.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:machine_care/utils/utils.dart';

class EditRepairController extends BaseController {
  late TextEditingController startDateController;
  late TextEditingController timeOfDayStartController;
  late TextEditingController noteTextController;
  Rx<String> message = ''.obs;
  Rx<String> content = ''.obs;
  StatusEnum statusEnum = StatusEnum.Waiting;

  @override
  void onInit() {
    super.onInit();
    setLoading(true);
    startDateController = TextEditingController();
    timeOfDayStartController = TextEditingController();
    noteTextController = TextEditingController();
    if (Get.arguments != null) {
      initData();
    }
    setLoading(false);
  }

  void initData() {
    MaintenanceScheduleEntity entity = Get.arguments as MaintenanceScheduleEntity;
    _target.value = entity.target ?? TargetMachine.frequent;
    if (entity.products != null) {
      selected.value.productId = entity.products;
    }
    starTime = entity.startDate;
    if (starTime != null) {
      startDateController.text = DateFormat('dd-MM-yyyy').format(starTime!.toLocal());
      timeOfDayStart.value =
          TimeOfDay(hour: starTime!.toLocal().hour, minute: starTime!.toLocal().minute);
      timeOfDayStartController.text =
          CurrencyFormatter.formatDateToTimeOfDay(timeOfDay: starTime!.toLocal());
    }
    if (entity.address != null) {
      address.value = entity.address!;
    }
    if (entity.errorMachine.isNotEmpty) {
      error.value = entity.errorMachine ;
    }
    noteTextController.text = entity.note ?? EndPoint.EMPTY_STRING;
    message.value = entity.note ?? EndPoint.EMPTY_STRING;
    statusEnum = entity.status ?? StatusEnum.Waiting;
  }

  final Rx<TargetMachine> _target = TargetMachine.frequent.obs;

  Rx<TargetMachine> get target => _target;

  void updateTarget({TargetMachine? state}) {
    if (state == null || state == _target.value) return;
    _target.value = state;
    if (_target.value != TargetMachine.frequent) {
      updateError([]);
    }
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

  DateTime? starTime;

  ValueNotifier<TimeOfDay> timeOfDayStart = ValueNotifier<TimeOfDay>(
      TimeOfDay(hour: DateTime.now().toLocal().hour, minute: DateTime.now().toLocal().minute));

  void updateStartDate(DateTime dateTime) {
    starTime = dateTime;
    timeOfDayStart.value = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
    _validateTimeNow(starTime ?? DateTime.now());
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
    starTime = DateTime(
      starTime!.year,
      starTime!.month,
      starTime!.day,
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
    if (DateTimeUtils.getDate(starTime!) ==
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

  Rx<UserAddress> address = UserAddress().obs;

  void updateAddress(UserAddress errors) {
    address.value = errors;
  }

  Rx<bool> get enable {
    return ((_target.value != TargetMachine.frequent ? error.isNotEmpty : error.isEmpty) &&
            starTime != null &&
            timeOfDayValidateState.value == CompareTimeState.none &&
            timeValidateState.value == CompareTimeState.none &&
            address.value.id != null)
        .obs;
  }

  void createRepair() async {
    setLoading(true);
    MaintenanceScheduleEntity _entity = MaintenanceScheduleEntity(
        errorMachine: error.value,
        note: message.value,
        startDate: starTime!.toUtc(),
        address: address.value,
        dueDate: starTime!.toUtc(),
        status: statusEnum);

    try {
      NetworkState state = await appRepository.updateRepair(
          id: (Get.arguments as MaintenanceScheduleEntity).sId.toString(), entity: _entity);
      if (state.isSuccess && state.data != null) {
        setLoading(false);
        Get.back(result: true);
        AppUtils.showToast("Chỉnh sửa lịch sửa chữa thành công!!!");
      } else {
        setLoading(false);
        AppUtils.showToast("Chỉnh sửa lịch sửa chữa không công!!!");
      }
    } catch (e) {
      setLoading(false);
      AppUtils.showToast("Chỉnh sửalịch sửa chữa không công!!!");
    }
  }
}
