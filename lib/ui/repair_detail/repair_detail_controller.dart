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

  ValueNotifier<StatusEnum> status = ValueNotifier<StatusEnum>(StatusEnum.Waiting);
  Rx<MaintenanceScheduleEntity> entity = MaintenanceScheduleEntity().obs;
  RxList<BugEntity> bugEntity = <BugEntity>[].obs;
  RxDouble rating = 3.0.obs;
  RxString comment = "".obs;
  TextEditingController commentRatingController = TextEditingController();
  Rx<TextEditingController> commentController = TextEditingController().obs;
  Rx<RatingEntity> ratingEntity = RatingEntity().obs;

  void updateRating(double value) {
    rating.value = value;
  }

  Future getMaintenanceSchedule({required String id}) async {
    setLoading(true);
    NetworkState state = await appRepository.getMaintenanceScheduleById(id: id);
    if (state.isSuccess && state.data != null) {
      entity.value = state.data as MaintenanceScheduleEntity;
      status.value = entity.value.status ?? StatusEnum.Waiting;
      bugEntity.value = entity.value.bugs;
      List<RatingEntity> ratings = entity.value.rating;
      if (ratings.isNotEmpty) {
        ratingEntity.value = ratings.elementAt(0);
      }
      await getComment(id: id);
    } else {
      AppUtils.showToast('load_api_fail'.tr);
    }
    setLoading(false);
  }

  void updateBug({required BugEntity entity}) async {
    bugEntity.insert(0, entity);
    this.entity.value.totalMoney = this.entity.value.totalMoney! + entity.priceBug!;
    NetworkState state =
        await appRepository.updateBug(entity: bugEntity.value, id: this.entity.value.sId!);
    if (state.isSuccess && state.data != null) {
      AppUtils.showToast('update_success'.tr);
    } else {
      AppUtils.showToast('update_fail'.tr);
    }
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
        ratingEntity.value = state.data as RatingEntity;
        setLoading(false);
        AppUtils.showToast('rating_success'.tr);
      } else {
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

  void onChangedContent(String value) {
    comment.value = value;
  }

  ValidateState contentState = ValidateState.none;

  void onFocusContent() {
    contentState = ValidateState.none;
  }

  RxList<CommentEntity> comments = <CommentEntity>[].obs;

  Future getComment({required String id}) async {
    NetworkState state = await appRepository.getComment(id: id);
    if (state.isSuccess && state.data != null) {
      comments.value = state.data as List<CommentEntity>;
      comments.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    } else {
      setLoading(false);
    }
  }

  void updateComment({required StatusEnum status}) async {
    if (entity.value.sId != null) {
      NetworkState state = await appRepository.updateStatus(status: status, id: entity.value.sId!);
      if (state.isSuccess && state.data != null) {
        this.status.value = status;
        Get.find<RepairController>().onRefresh();
        AppUtils.showToast('update_success'.tr);
      } else {
        AppUtils.showToast('update_fail'.tr);
      }
    }
  }

  void addComment() async {
    CommentEntity commentEntity =
        CommentEntity(id: '', maintenance: entity.value.sId, contentComment: comment.value);
    NetworkState data = await appRepository.addComment(entity: commentEntity);
    if (data.isSuccess && data.data != null) {
      comments.insert(0, (data.data as CommentEntity));
      AppUtils.showToast('comment_success'.tr);
    } else {
      AppUtils.showToast('comment_fail'.tr);
    }
  }
}
