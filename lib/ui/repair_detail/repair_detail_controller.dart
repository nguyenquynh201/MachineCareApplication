import 'package:flutter/cupertino.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/utils/app_pref.dart';
import 'package:machine_care/utils/app_utils.dart';

import '../ui.dart';

class RepairDetailController extends BaseController {
  @override
  void onInit() async {
    super.onInit();

    if (Get.arguments != null) {
      await getMaintenanceSchedule(id: (Get.arguments as MaintenanceScheduleEntity).sId ?? "");
    }
  }

  Rx<MaintenanceScheduleEntity> entity = MaintenanceScheduleEntity().obs;
  RxDouble rating = 3.0.obs;
  RxString comment = "".obs;
  TextEditingController commentRatingController = TextEditingController();
  Rx<RatingEntity> ratingEntity = RatingEntity().obs;

  void updateRating(double value) {
    rating.value = value;
  }

  Future getMaintenanceSchedule({required String id}) async {
    setLoading(true);
    NetworkState state = await appRepository.getMaintenanceScheduleById(id: id);
    if (state.isSuccess && state.data != null) {
      entity.value = state.data as MaintenanceScheduleEntity;
      List<RatingEntity>  ratings= entity.value.rating ?? [];
      if(ratings.isNotEmpty) {
        ratingEntity.value = ratings.elementAt(0);
      print("nè nè ${ratingEntity.value}");
      }
    } else {
      AppUtils.showToast('load_api_fail'.tr);
    }
    setLoading(false);
  }

  void feedBackRating() async {
    RatingEntity entity = RatingEntity(
        userId: AppPref.user.sId,
        comment: comment.value,
        rating: num.parse(rating.value.toString()),
        maintenanceId: this.entity.value.sId);
    try {
      setLoading(true);
      NetworkState state = await appRepository.updateRating(entity: entity);
      if (state.isSuccess && state.data != null) {
        ratingEntity?.value = state.data as RatingEntity;
        setLoading(false);
        AppUtils.showToast('rating_success'.tr);
      }else {
        setLoading(false);
        AppUtils.showToast('rating_fail'.tr);
      }
    } catch (e) {
      setLoading(false);
      AppUtils.showToast('rating_fail'.tr);
    }
  }

  Rx<bool> get enable {
    return (comment.isNotEmpty && rating.value != 0).obs;
  }
}
