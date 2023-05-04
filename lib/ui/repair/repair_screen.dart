import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/routers/app_routes.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:machine_care/utils/utils.dart';
import 'package:table_calendar/table_calendar.dart';

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
          Obx(() => Column(
                children: [],
              )),
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

  Widget _buildCalendars({
    required DateTime fromDate,
    required DateTime toDate,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Column(
        children: [
          TableCalendar(
            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
              controller.updateCurrentDate(selectedDay);
            },
            firstDay: DateTime.utc(
              fromDate.year - 1,
              fromDate.month,
              fromDate.day,
            ),
            lastDay: DateTime.utc(
              fromDate.year + 1,
              fromDate.month,
              fromDate.day,
            ),
            calendarFormat: CalendarFormat.month,
            availableGestures: AvailableGestures.horizontalSwipe,
            pageJumpingEnabled: false,
            pageAnimationEnabled: false,
            headerVisible: false,
            calendarStyle: const CalendarStyle(
                isTodayHighlighted: false,
                selectedDecoration: BoxDecoration(color: AppColor.primary, shape: BoxShape.circle)),
            selectedDayPredicate: (day) {
              return DateTimeUtils.isWithinDays(fromDate, toDate, day);
            },
            daysOfWeekVisible: false,
            rowHeight: 70,
            focusedDay: fromDate,
            calendarBuilders: CalendarBuilders(markerBuilder: (context, day, events) {
              return Indicator(
                dayOfWeek: day,
                typeCalendar: "todo",
                controller: controller,
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedDateHeader({
    required DateTime fromDate,
    required DateTime toDate,
  }) {
    return Obx(() => Container(
          width: Get.width,
          height: 48,
          margin: const EdgeInsets.only(
            top: 8,
            bottom: 16,
            left: 16,
            right: 12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          (DateTimeUtils.isSameDate(fromDate, toDate))
                              ? _currentDateToString(fromDate)
                              : "${_currentDateToString(fromDate)} - ${_currentDateToString(toDate)}",
                          style: AppTextStyles.customTextStyle().copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    UIIconButton(
                      child: RotatedBox(
                        quarterTurns: controller.showCalendar ? 1 : 3,
                        child: const WidgetSvg(
                          path: AppImages.iconChevronLeft,
                          height: 32,
                          width: 32,
                          fit: BoxFit.contain,
                        ),
                      ),
                      onPressed: () {
                        controller.updateBoolShowCalendar();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  String _currentDateToString(DateTime currentDate) {
    final day = DateFormat("dd").format(currentDate);
    var monthString = currentDate.month.toString();
    print("MonthString: $monthString");
    switch (int.parse(monthString)) {
      case 1:
        monthString = 'jan'.tr;
        break;
      case 2:
        monthString = 'feb'.tr;
        break;
      case 3:
        monthString = 'mar'.tr;
        break;
      case 4:
        monthString = 'apr'.tr;
        break;
      case 5:
        monthString = 'sMay'.tr;
        break;
      case 6:
        monthString = 'jun'.tr;
        break;
      case 7:
        monthString = 'jul'.tr;
        break;
      case 8:
        monthString = 'aug'.tr;
        break;
      case 9:
        monthString = 'sep'.tr;
        break;
      case 10:
        monthString = 'oct'.tr;
        break;
      case 11:
        monthString = 'nov'.tr;
        break;
      case 12:
        monthString = 'dec'.tr;
        break;
      default:
        monthString = 'jan'.tr;
        break;
    }
    final year = DateFormat.y(Intl.defaultLocale).format(currentDate);
    return "$day $monthString, $year";
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
    MaintenanceScheduleEntity entity = data[index];
    return GestureDetector(
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (entity.maintenanceContent != EndPoint.EMPTY_STRING)
                              ? entity.maintenanceContent!
                              : StringUtils.targetMachineType(targetMachine: entity.target),
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
                    _buildTimeLine(startTime: entity.startDate ?? DateTime.now()),
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
                        totalMoney:
                            CurrencyFormatter.encoded(price: entity.totalBugMoney!.toString()),
                      ),
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
                    color: StringUtils.statusTypeColor(data[index].status))),
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
