import 'package:flutter/material.dart';
import 'package:machine_care/constants/app_colors.dart';
import 'package:machine_care/constants/app_text_styles.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/routers/app_routes.dart';
import 'package:machine_care/utils/utils.dart';

import '../ui.dart';

class NotificationDetailScreen extends BaseScreen<NotificationDetailController> {
  NotificationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetLoadingFullScreen<NotificationDetailController>(
        child: Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        children: [
          WidgetHeader(
            title: 'notification_detail'.tr,
            isBackground: true,
          ),
          Expanded(child: GetX<NotificationDetailController>(
            builder: (_) {
              if (_.entity.value.id == null) {
                return const WidgetEmptyData(title: 'load_api_fail');
              }
              return _buildBody();
            },
          ))
        ],
      ),
    ));
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            _buildWidgetInfo(entity: controller.entity.value),
            Visibility(
                visible: (!(controller.entity.value.assign ?? false) && (AppPref.user.role != null && AppPref.user.role == 'staff')), child: _buildWidgetButton())
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetButton() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColor.colorBanner,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            'title_confirm'.tr,
            style: AppTextStyles.customTextStyle().copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: AppColor.colorTitleHome,
                fontFamily: Fonts.Quicksand.name),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  child: WidgetButton(
                title: 'confirm'.tr,
                typeButton: TypeButton.none,
                enabled: true,
                backgroundColor: AppColor.colorButton,
                onPressed: () async {
                  final _ = await Get.dialog(
                    DialogConfirm(
                      title: 'maintenance_schedule'.tr,
                      content: 'title_confirm_dialog'.tr,
                      titleCancel: "close".tr,
                      titleConfirm: "confirm".tr,
                    ),
                  );
                  if (_ != null && _) {
                    String idAdmin =
                        controller.entity.value.object?.idUser ?? EndPoint.EMPTY_STRING;
                    String idMaintenance =
                        controller.entity.value.object?.idMaintenance ?? EndPoint.EMPTY_STRING;
                    if (idAdmin.isNotEmpty && idMaintenance.isNotEmpty) {
                      controller.updateRequestApply(
                          id: idMaintenance, isReceive: true, idAdmin: idAdmin);
                    }
                  }
                },
              )),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: WidgetButton(
                title: 'no_confirm'.tr,
                isLine: true,
                typeButton: TypeButton.none,
                enabled: true,
                backgroundColor: AppColor.primary,
                onPressed: () async {
                  final _ = await Get.dialog(
                    DialogConfirm(
                      title: 'maintenance_schedule'.tr,
                      content: 'title_no_confirm_dialog'.tr,
                      titleCancel: "close".tr,
                      titleConfirm: "confirm".tr,
                    ),
                  );
                  if (_ != null && _) {
                    String idAdmin =
                        controller.entity.value.object?.idUser ?? EndPoint.EMPTY_STRING;
                    String idMaintenance =
                        controller.entity.value.object?.idMaintenance ?? EndPoint.EMPTY_STRING;

                    if (idAdmin.isNotEmpty && idMaintenance.isNotEmpty) {
                      controller.updateRequestApply(
                          id: idMaintenance, isReceive: false, idAdmin: idAdmin);
                    }
                  }
                },
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetInfo({required NotificationEntity entity}) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColor.colorBanner),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(
            title: "Nội dung: ${entity.title ?? ""}",
            des: "Mô tả: ${entity.description ?? ""}",
            time: "Thời gian: ${StringUtils.getDifferenceTimeString(dateStr: entity.createdAt!)}",
          ),
          if (controller.maintenanceScheduleEntity.value.sId != null) _buildRepair()
        ],
      ),
    );
  }

  Widget _buildRepair() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'maintenance_schedule'.tr,
            style: AppTextStyles.customTextStyle().copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColor.colorTitleHome,
                fontFamily: Fonts.Quicksand.name),
          ),
          WidgetItemRepair(
              entity: controller.maintenanceScheduleEntity.value,
              onPressed: () async {
                Get.toNamed(Routes.repairDetail,
                    arguments: controller.maintenanceScheduleEntity.value);
              })
        ],
      ),
    );
  }

  Widget _buildHeader({required String title, required String des, required String time}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.customTextStyle().copyWith(
              fontSize: 20,
              color: AppColor.colorTitleHome,
              fontFamily: Fonts.Quicksand.name,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          des,
          style: AppTextStyles.customTextStyle().copyWith(
              fontSize: 16,
              color: AppColor.description,
              fontFamily: Fonts.Quicksand.name,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          time,
          style: AppTextStyles.customTextStyle().copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: AppColor.description,
              fontFamily: Fonts.Quicksand.name),
        )
      ],
    );
  }
}
