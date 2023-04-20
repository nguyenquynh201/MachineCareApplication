import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/enum/validate.dart';
import 'package:machine_care/routers/app_routes.dart';
import 'package:machine_care/utils/app_pref.dart';

import '../ui.dart';

class ProfileScreen extends BaseScreen<ProfileController> {
  ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return WidgetListenableProfile(builder: (_, user, __) {
      UserEntity model = user ?? UserEntity();
      return Scaffold(
        backgroundColor: AppColor.white,
        body: RefreshIndicator(
          onRefresh: () async {},
          child: SingleChildScrollView(
            child: Column(
              children: [
                WidgetHeader(
                  title: 'account'.tr,
                  leading: Container(),
                ),
                WidgetItemProfile(title: '', icon: '' , user: model , onPress: () {

                }),
                const SizedBox(height: 43,),
                WidgetItemProfile(title: 'address_book'.tr, icon: AppImages.icAddress , color: AppColor.colorAddressBook , onPress: () {
                  Get.toNamed(Routes.address);
                }),
                const SizedBox(height: 14,),
                WidgetItemProfile(title: 'setting'.tr, icon: AppImages.icSetting , color: AppColor.colorSetting),
                const SizedBox(height: 14,),
                WidgetItemProfile(title: 'feedback'.tr, icon: AppImages.icFeedback , color: AppColor.colorFeedback),
                WidgetItemProfile(title: 'support'.tr, icon: AppImages.icSupport , color: AppColor.colorSupport),
                WidgetItemProfile(title: 'help'.tr, icon: AppImages.icHelp , color: AppColor.colorHelp),
                const SizedBox(height: 14,),
                WidgetItemProfile(title: 'log_out'.tr, icon: AppImages.iconLogin , color: AppColor.primary),
                const SizedBox(height: 43,),
                const WidgetImageAsset(url: AppImages.icApp)
              ],
            ),
          ),
        ),
      );
    });
  }


}
