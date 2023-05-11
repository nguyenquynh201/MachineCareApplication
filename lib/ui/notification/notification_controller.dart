import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/routers/app_routes.dart';
import 'package:machine_care/ui/base/base.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationController extends BaseController {
  late RefreshController refreshController;

  @override
  void onInit() async {
    super.onInit();
    refreshController = RefreshController();
    setLoading(true);
    await getNotification();
    setLoading(false);
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }

  int total = 0;
  RxList notifications = [].obs;

  void onRefresh() async {
    try {
      total = 0;
      notifications.clear();
      await getNotification();
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
    }
  }

  Future getNotification() async {
    if (total != 0 && total == notifications.length) {
      refreshController.loadComplete();
      return [];
    }
    NetworkState state =
        await appRepository.getNotification(offset: notifications.length, limit: EndPoint.LIMIT);
    if (state.isSuccess && state.data != null) {
      if (total == 0) {
        notifications.clear();
      }
      notifications.addAll(state.data);
      refreshController.loadComplete();
      total = state.total ?? 0;
      print("nè nè $total");
    } else {
      refreshController.loadFailed();
    }
  }

  void readNotification({required NotificationEntity entity}) async {
    if ((entity.isRead ?? false)) {
      final _ = await Get.toNamed(Routes.notificationDetail, arguments: entity);
    } else {
      NetworkState state = await appRepository.readNotification(id: entity.id ?? "");
      if (state.isSuccess && state.data != null) {
        if(!(entity.isRead ?? false)){
          entity.isRead = true;
        }
        final _ = await Get.toNamed(Routes.notificationDetail, arguments: entity);
        if(_ != null && _) {
          onRefresh();
        }
      }
    }
  }

  scrollToTop() {
    refreshController.position?.jumpTo(0);
  }
}
