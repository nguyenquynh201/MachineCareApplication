import 'package:flutter/material.dart';
import 'package:machine_care/routers/app_routes.dart';

import '../ui/ui.dart';

class AppPages extends Routes {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey();
  static final pages = [
    GetPage(name: Routes.mainNavigation, page: () => MainNavigationScreen(), bindings: [
      MainNavigationBinding(),
      HomeBinding(),
      NotificationBinding(),
      RepairBinding(),
      ProductBinding(),
      ProfileBinding(),
    ]),
    GetPage(name: Routes.navigation, page: () => NavigationScreen(), binding: NavigationBinding()),
    GetPage(
      name: Routes.login,
      binding: LoginBinding(),
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.resetPassword,
      binding: ResetPasswordBinding(),
      page: () => ResetPasswordScreen(),
    ),
    GetPage(
      name: Routes.information,
      binding: InformationBinding(),
      page: () => InformationScreen(),
    ),
    GetPage(
      name: Routes.createRepair,
      binding: CreateRepairBinding(),
      page: () => CreateRepairScreen(),
    ),
    GetPage(
      name: Routes.address,
      binding: AddressBinding(),
      page: () => AddressScreen(),
    ),
    GetPage(
      name: Routes.createEditAddress,
      binding: CreateEditAddressBinding(),
      page: () => CreateEditAddressScreen(),
    ),
    GetPage(
      name: Routes.repairDetail,
      binding: RepairDetailBinding(),
      page: () => RepairDetailScreen(),
    ),
    GetPage(
      name: Routes.repairEdit,
      binding: EditRepairBinding(),
      page: () => EditRepairScreen(),
    ),
    GetPage(
      name: Routes.repairHistory,
      binding: HistoryRepairBinding(),
      page: () => HistoryRepairScreen(),
    ),
    GetPage(
      name: Routes.notificationDetail,
      binding: NotificationDetailBinding(),
      page: () => NotificationDetailScreen(),
    ),
    GetPage(
      name: Routes.productDetail,
      binding: ProductDetailBinding(),
      page: () => ProductDetailScreen(),
    ),
  ];
}
