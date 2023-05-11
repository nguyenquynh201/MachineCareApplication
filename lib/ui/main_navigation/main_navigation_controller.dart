import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:machine_care/constants/app_images.dart';
import 'package:machine_care/resources/model/model.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/ui/base/base.dart';
import 'package:machine_care/ui/notification/notification.dart';
import 'package:machine_care/ui/home/home.dart';
import 'package:machine_care/ui/product/product_controller.dart';
import 'package:machine_care/ui/profile/profile.dart';
import 'package:machine_care/ui/repair/repair.dart';
import 'package:machine_care/utils/utils.dart';

class MainNavigationController extends BaseController {
  int lastClickBack = 0;
  final currentPage = 0.obs;
  List<String> imagesSelectUser = [
    AppImages.iconMenuHome,
    AppImages.icNotification,
    AppImages.iconMenuRepair,
    AppImages.iconMenuProduct,
    AppImages.iconMenuProfile,
  ].obs;
  List<String> imagesSelectStaff = [
    AppImages.iconMenuHome,
    AppImages.icNotification,
    AppImages.iconMenuRepair,
    AppImages.iconMenuProfile,
  ].obs;
  @override
  onInit() async{
    super.onInit();
    GALogger.logEvent(GALogger.screenView,
        {GALogger.screenName: "H01_explore", GALogger.description: "Màn Trang chủ"});
    await getBanner();
    await getStatus();
    await updateToken();
  }
  Future updateToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
        await appRepository.updateToken(token: token);
    }
  }
  Future getBanner() async {
    NetworkState state = await appRepository.getBanner();
    if(state.isSuccess && state.data != null) {
      List<BannerEntity> entity = state.data;
      if(entity.first.image != null) {
        AppPref.banner = entity.first.image ?? [];
        DataFilter.banners.value = state.data.first.image ;
      }
    }
  }

  Future getStatus() async {
    NetworkState state = await appRepository.getStatus();
    if(state.isSuccess && state.data != null) {
        DataFilter.status.value = state.data;
    }
  }
  changePage(int index) {
    if (index != currentPage.value) {
      currentPage.value = index;
      GALogger.logEvent(
        GALogger.screenView,
        {
          GALogger.screenName: showGALogger.keys.elementAt(index),
          GALogger.description: showGALogger.values.elementAt(index)
        },
      );
    } else {
      if(AppPref.user.sId != null && AppPref.user.role == 'staff') {
        pageStaff(index);
      }else {
        pageUser(index);
      }

    }
  }
  pageUser(int index) {
    if (index == 0) {
      Get.find<HomeController>().scrollToTop();
    }
    if (index == 1) {
      Get.find<NotificationController>().scrollToTop();
    }
    if (index == 2) {
      Get.find<RepairController>().scrollToTop();
    }
    if (index == 3) {
      Get.find<ProductController>().scrollToTop();
    }
    if (index == 4) {
      Get.find<ProfileController>().scrollToTop();
    }
  }
  pageStaff(int index) {
    if (index == 0) {
      Get.find<HomeController>().scrollToTop();
    }
    if (index == 1) {
      Get.find<NotificationController>().scrollToTop();
    }
    if (index == 2) {
      Get.find<RepairController>().scrollToTop();
    }
    if (index == 3) {
      Get.find<ProfileController>().scrollToTop();
    }
  }
  Map<String, String> showGALogger = {
    'H01_explore': 'Màn hình trang chủ',
    'HTR01_history': 'Màn hình lịch sử',
    'SC01_notification_screen': 'Màn thông báo ',
    'SP01_product': 'Màn hình sản phẩm',
    'CA01_me': 'Trang cá nhân'
  };
}
