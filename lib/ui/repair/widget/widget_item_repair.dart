import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/utils/utils.dart';

import '../../ui.dart';
class WidgetItemRepair extends StatelessWidget {
  const WidgetItemRepair({Key? key, required this.entity, required this.onPressed}) : super(key: key);
  final MaintenanceScheduleEntity entity;
  final VoidCallback onPressed;
  static EdgeInsets padding = const EdgeInsets.symmetric(
    vertical: 10,
    horizontal: 24,
  );
  static const EdgeInsets zero = EdgeInsets.only();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: padding,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.colorBgProfile,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "${'service'.tr}: ${StringUtils.targetMachineType(targetMachine: entity.target)}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.customTextStyle().copyWith(
                            color: AppColor.colorButton,
                            fontSize: 18,
                            fontFamily: Fonts.Quicksand.name,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    _buildTimeLine(startTime: entity.startDate ?? DateTime.now()),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (entity.totalMoney != null)
                      _buildTotalMoney(
                        totalMoney:
                        CurrencyFormatter.encoded(price: entity.totalMoney.toString()),
                      ),
                    const SizedBox(width: 10,),
                    if (entity.status != null) _buildStatus(entity: entity.status),
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
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                    color: StringUtils.statusTypeColor(entity.status!))),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalMoney({required String totalMoney}) {
    return Text(
      "${'total_money'.tr}: ${totalMoney.toString()} VND",
      style: AppTextStyles.customTextStyle().copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColor.colorHelp,
          fontFamily: Fonts.Quicksand.name),
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
            fontSize: 13,
            fontFamily: Fonts.Quicksand.name,
            fontWeight: FontWeight.w400,
            color: AppColor.colorTitleHome,
          ),
        ),
      ],
    );
  }

  Widget _buildStatus({StatusEnum? entity}) {
    if (entity != null) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        decoration: BoxDecoration(
            color: StringUtils.statusTypeColor(entity).withOpacity(0.2),
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          StringUtils.statusValueOf(entity),
          style: AppTextStyles.customTextStyle().copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              fontFamily: Fonts.Quicksand.name,
              color: StringUtils.statusTypeColor(entity)),
        ),
      );
    } else {
      return Container();
    }
  }
}
