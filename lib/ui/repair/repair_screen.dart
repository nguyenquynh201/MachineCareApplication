import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/routers/app_routes.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:machine_care/utils/utils.dart';

class RepairScreen extends BaseScreen<RepairController> {
  RepairScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        children: [
          WidgetHeader(
            title: 'maintenance_schedule'.tr,
            actions: [
              GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.createRepair);
                  },
                  child: const WidgetSvg(
                    path: AppImages.icAdd,
                    width: 24,
                    height: 24,
                    color: AppColor.colorButton,
                  ))
            ],
            leading: Container(),
          ),
          Expanded(child: GetX<RepairController>(
            builder: (_) {
              return WidgetLoadMoreRefresh(
                controller: _.refreshController,
                onLoadMore: _.getMaintenanceSchedule,
                onRefresh: _.onRefresh,
                child: _.loading.value
                    ? const WidgetLoading()
                    : SingleChildScrollView(
                  child: WidgetListMaintenanceSchedule(controller: _),
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
class WidgetListMaintenanceSchedule extends StatelessWidget {
  const WidgetListMaintenanceSchedule({Key? key, required this.controller}) : super(key: key);
  final RepairController controller;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: controller.maintenanceSchedule.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return itemBuilder(controller.maintenanceSchedule, index);
        });
  }
  static EdgeInsets padding = const EdgeInsets.symmetric(
    vertical: 10,
    horizontal: 24,
  );
  static const EdgeInsets zero = EdgeInsets.only();

  Widget itemBuilder(List<dynamic> data, int index) {
    final entity =  data[index];
    return GestureDetector(
      child: Stack(
        children: [
          Container(
            margin:
            const EdgeInsets.symmetric(vertical: 8),
            padding: padding,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.colorBgProfile,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entity.maintenanceContent ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.customTextStyle().copyWith(
                              color: AppColor.colorButton,
                              fontSize: 18,
                              fontFamily: Fonts.Quicksand.name,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          StringUtils.targetMachineType(targetMachine: entity.target),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.customTextStyle().copyWith(
                              color: AppColor.colorTitleHome,
                              fontSize: 14,
                              fontFamily: Fonts.Quicksand.name,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    _buildTimeLine(startTime: entity.startDate),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (entity.totalBugMoney != null)
                      _buildTotalMoney(
                        totalMoney: CurrencyFormatter.encoded(
                            price: entity.totalBugMoney!.toString()),
                      ),
                    if(entity.status != null)
                      _buildStatus(entity: entity.status),
                  ],
                )

              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 25,
            child: Container(
              height: 24,
              width: 7,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(
                    4
                  ),
                  bottomRight: Radius.circular(
                  4
                  ),
                ),
                color: !StringUtils.isEmpty(data[index].status?.color)
                    ? HexColor.fromHex(data[index].status?.color)
                    : AppColor.primary,)
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTotalMoney(
      {required String totalMoney}) {
    return Text(
      "${'total_money'.tr}: ${totalMoney.toString()} VND",
      style: AppTextStyles.customTextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColor.colorHelp,
        fontFamily: Fonts.Quicksand.name
      ),
    );
  }
  Widget _buildTimeLine({
    required DateTime startTime,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      const WidgetSvg(
          path: AppImages.icCalendar,
          width: 16,
          height: 16,
          fit: BoxFit.contain,
        color: AppColor.colorTitleHome,
        ),
        const SizedBox(width: 4),
        Text(
          DateFormat('dd/MM/yyyy').format(startTime),
          style: AppTextStyles.customTextStyle().copyWith(
            fontSize:13,
            fontFamily: Fonts.Quicksand.name,
            fontWeight: FontWeight.w400,
            color: AppColor.colorTitleHome,
          ),
        ),
      ],
    );
  }
  Widget _buildStatus({StatusEntity? entity}) {
  if(entity != null) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,),
      decoration: BoxDecoration(
          color:  !StringUtils.isEmpty(entity.color)
              ? HexColor.fromHex(entity.color).withOpacity(0.5)
              : AppColor.primary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(
              20)),
      child: Text(
        entity.name ,
        style: AppTextStyles.customTextStyle().copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          fontFamily: Fonts.Quicksand.name,
          color: !StringUtils.isEmpty(entity.color)
              ? HexColor.fromHex(entity.color)
              : AppColor.primary,),
      ),
    );
  }else {
    return Container();
  }



  }
}
