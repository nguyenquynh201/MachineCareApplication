import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:machine_care/utils/app_utils.dart';

class NotificationDetailController extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      await getNotificationById(id: (Get.arguments as NotificationEntity).id ?? "");
    }
  }

  Rx<NotificationEntity> entity = NotificationEntity().obs;
  Rx<MaintenanceScheduleEntity> maintenanceScheduleEntity = MaintenanceScheduleEntity().obs;

  Future getNotificationById({required String id}) async {
    setLoading(true);
    NetworkState state = await appRepository.getNotificationById(id: id);
    if (state.isSuccess && state.data != null) {
      entity.value = state.data as NotificationEntity;
      if (entity.value.object != null && entity.value.object!.idMaintenance != null) {
        await getMaintenanceSchedule(id: entity.value.object!.idMaintenance!);
      }
      setLoading(false);
    } else {
      setLoading(false);
      AppUtils.showToast('load_api_fail'.tr);
    }
  }

  Future getMaintenanceSchedule({required String id}) async {
    NetworkState state = await appRepository.getMaintenanceScheduleById(id: id);
    if (state.isSuccess && state.data != null) {
      maintenanceScheduleEntity.value = state.data as MaintenanceScheduleEntity;
    } else {
      setLoading(false);
      AppUtils.showToast('load_api_fail'.tr);
    }
  }
  void updateRequestApply({required String id , required bool isReceive , required String idAdmin}) async{
    setLoading(true);
    Map<String , dynamic> data = {
      "isReceive" : isReceive
    };
    NetworkState state = await appRepository.updateRequestReceived(id: id, idAdmin: idAdmin, data: data);
    if(state.isSuccess && state.data != null) {
      setLoading(false);
      AppUtils.showToast('update_success'.tr);
      Get.back(result: true);
    }else {
      setLoading(false);
      AppUtils.showToast('update_fail'.tr);
    }
  }
}
