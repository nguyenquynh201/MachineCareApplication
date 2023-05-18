import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:machine_care/utils/utils.dart';

class NotificationScreen extends BaseScreen<NotificationController> {
  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        children: [
          WidgetHeader(
            title: 'notification'.tr,
            leading: Container(),
          ),
          Expanded(child: _buildBody())
        ],
      ),
    );
  }

  Widget _buildBody() {
    return GetX<NotificationController>(builder: (_) {
      return WidgetLoadMoreRefresh(
        controller: _.refreshController,
        onLoadMore: _.getNotification,
        onRefresh: _.onRefresh,
        isNotEmpty: _.notifications.isNotEmpty,
        child: _.loading.value
            ? const WidgetLoading()
            : SingleChildScrollView(
                child: WidgetListNotification(
                  controller: _,
                ),
              ),
      );
    });
  }
}

class WidgetListNotification extends StatelessWidget {
  const WidgetListNotification({Key? key, required this.controller}) : super(key: key);
  final NotificationController controller;

  @override
  Widget build(BuildContext context) {
    return GetX<NotificationController>(
      builder: (_) {
        return ListView.builder(
            itemCount: controller.notifications.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return itemBuilder(controller.notifications, index);
            });
      }
    );
  }

  Widget itemBuilder(List<dynamic> data, int index) {
    NotificationEntity entity = data[index];
    return WidgetItemNotification(
      entity: entity,
      onPressed: () async {
        controller.readNotification(entity: entity);
      },
    );
  }
}

class WidgetItemNotification extends StatelessWidget {
  const WidgetItemNotification({Key? key, required this.entity, required this.onPressed})
      : super(key: key);
  final NotificationEntity entity;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        padding: const EdgeInsets.only(
          left: 12,
          bottom: 8,
          right: 16,
          top: 16,
        ),
        decoration: BoxDecoration(
            color: (entity.isRead == false) ? AppColor.colorBanner : AppColor.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 10),
                  color: AppColor.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 1)
            ]),
        child: Row(
          children: [
            _buildThumbnail(url: entity.author?.avatar),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    !StringUtils.isEmpty(entity.author?.fullName)
                        ? "Gửi tới : ${entity.author!.fullName}"
                        : "",
                    style: AppTextStyles.customTextStyle().copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColor.colorTitleHome,
                        fontFamily: Fonts.Quicksand.name),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Nội dung: ${entity.title}",
                    style: AppTextStyles.customTextStyle().copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.colorTitleHome,
                        fontFamily: Fonts.Quicksand.name),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    StringUtils.getDifferenceTimeString(dateStr: entity.createdAt!),
                    style: AppTextStyles.customTextStyle().copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColor.description,
                        fontFamily: Fonts.Quicksand.name),
                  )
                ],
              ),
            ),
            Visibility(
                visible: !(entity.isRead ?? false),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: Container(
                    decoration:
                        const BoxDecoration(color: AppColor.borderError, shape: BoxShape.circle),
                    height: 8,
                    width: 8,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail({String? url}) {
    if (url != null) {
      return WidgetImageNetwork(
          url: url,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
          borderRadius: BorderRadius.circular(12),
          placeHolderType: PlaceHolderType.typeNothing);
    }
    return WidgetImageNetwork(
        url: AppImages.icNoAvatar,
        width: 40,
        fit: BoxFit.contain,
        height: 40,
        borderRadius: BorderRadius.circular(12),
        placeHolderType: PlaceHolderType.avatar);
  }
}
