import 'package:flutter/material.dart';
import 'package:machine_care/constants/app_colors.dart';
import 'package:machine_care/constants/app_images.dart';
import 'package:machine_care/constants/app_text_styles.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:machine_care/utils/currency_formatter.dart';

class HistoryRepairScreen extends BaseScreen<HistoryRepairController> {
  HistoryRepairScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorBanner,
      body: Column(
        children: [
          WidgetHeader(
            title: 'history_repair'.tr,
            isBackground: true,
          ),
          Expanded(
            child: GetX<HistoryRepairController>(builder: (_) {
              return WidgetLoadMoreRefresh(
                controller: _.refreshController,
                onLoadMore: _.getHistory,
                isNotEmpty: _.history.isNotEmpty,
                onRefresh: _.onRefresh,
                child: _.loading.value
                    ? const WidgetLoading()
                    : SingleChildScrollView(
                        child: WidgetListHistory(controller: _),
                      ),
              );
            }),
          )
        ],
      ),
    );
  }
}

class WidgetListHistory extends StatelessWidget {
  const WidgetListHistory({Key? key, required this.controller}) : super(key: key);
  final HistoryRepairController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: controller.groupedHistories.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return _buildLabelAndHistories(histories: controller.groupedHistories, idx: index);
        });
  }

  Widget _buildLabelAndHistories({
    required Map<DateTime, List<HistoryRepairEntity>> histories,
    required int idx,
  }) {
    DateTime dateUTC = histories.keys.elementAt(idx);
    DateTime dateNow = dateUTC.toLocal();
    String convertedDateTime =
        " ${dateNow.day.toString().padLeft(2, '0')}/${dateNow.month.toString().padLeft(2, '0')}/${dateNow.year.toString().padLeft(2, '0')}";
    print(convertedDateTime);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTimeLabel(
          time: convertedDateTime,
        ),
        _buildListHistories(histories: histories.values.elementAt(idx)),
      ],
    );
  }

  Widget _buildTimeLabel({
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        left: 8,
        right: 8,
      ),
      child: Text(
        time,
        style: AppTextStyles.customTextStyle().copyWith(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: AppColor.colorTitleHome,
          fontFamily: Fonts.Quicksand.name,
        ),
      ),
    );
  }

  Widget _buildListHistories({required List<HistoryRepairEntity> histories}) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (_, idx) {
        return _buildModifiedInfo(
          index: idx,
          entity: histories.elementAt(idx),
          onPressed: () async {},
        );
      },
      itemCount: histories.length,
      shrinkWrap: true,
    );
  }

  Widget _buildModifiedInfo({
    required int index,
    required HistoryRepairEntity entity,
    VoidCallback? onPressed,
  }) {
    String content = "";
    if (entity.status == "update") {
      content = '${entity.updatedBy?.fullName} đã cập nhật thông tin';
    } else {
      content = '${entity.updatedBy?.fullName} đã chỉnh sửa thông tin';
    }

    String convertedDateTime = "";
    if (entity.id != null) {
      DateTime dateUTC = entity.createdAt ?? DateTime.now();
      String time = CurrencyFormatter.formatDateToTimeOfDay(
          timeOfDay: entity.createdAt?.toLocal() ?? DateTime.now().toLocal());
      convertedDateTime =
          " ${dateUTC.day.toString().padLeft(2, '0')}/${dateUTC.month.toString().padLeft(2, '0')}/${dateUTC.year.toString().padLeft(2, '0')}  $time";
    }
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration:
          BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
            color: AppColor.black.withOpacity(0.2),
            offset: const Offset(0, 10),
            blurRadius: 15,
            spreadRadius: 0)
      ]),
      child: Row(
        children: [
          _buildThumbnail(url: entity.updatedBy?.avatar),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleContent(content: content),
              const SizedBox(
                height: 5,
              ),
              _buildSummaryContent(content: convertedDateTime),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSummaryContent({
    required String content,
  }) {
    return Text(
      content,
      style: AppTextStyles.customTextStyle().copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppColor.colorTitleHome,
          fontFamily: Fonts.Quicksand.name),
      maxLines: 2,
    );
  }

  Widget _buildTitleContent({
    required String content,
  }) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 250),
      child: Text(
        content,
        maxLines: 1,
        style: AppTextStyles.customTextStyle().copyWith(
            fontSize: 18,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w600,
            color: AppColor.colorTitleHome,
            fontFamily: Fonts.Quicksand.name),
      ),
    );
  }

  Widget _buildThumbnail({String? url}) {
    if (url != null) {
      return WidgetImageNetwork(
          url: url,
          width: 40,
          height: 40,
          borderRadius: BorderRadius.circular(12),
          placeHolderType: PlaceHolderType.typeNothing);
    }
    return WidgetImageNetwork(
        url: AppImages.icNoAvatar,
        width: 40,
        fit: BoxFit.cover,
        height: 40,
        borderRadius: BorderRadius.circular(12),
        placeHolderType: PlaceHolderType.avatar);
  }
}

class WidgetItemHistory extends StatefulWidget {
  const WidgetItemHistory({Key? key, required this.entity}) : super(key: key);
  final HistoryRepairEntity entity;

  @override
  State<WidgetItemHistory> createState() => _WidgetItemHistoryState();
}

class _WidgetItemHistoryState extends State<WidgetItemHistory> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
