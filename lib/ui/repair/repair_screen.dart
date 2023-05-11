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
              (AppPref.user.sId != null && AppPref.user.role == 'staff')
                  ? Container()
                  : GestureDetector(
                      onTap: () async {
                        final _ = await Get.toNamed(Routes.createRepair);
                        if (_ && _ != null) {
                          controller.onRefresh();
                        }
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
         Expanded(child: _buildBody())
        ],
      ),
    );
  }
  Widget _buildBody() {
    return GetX<RepairController>(builder: (_) {
      return Column(
        children: [
          Column(
            children: [
              _buildSelectedDateHeader(
                  fromDate: controller.fromDate.value, toDate: controller.toDate.value),
              if(controller.showCalendar.value)
                _buildCalendars(
                    fromDate: controller.fromDate.value, toDate: controller.toDate.value , onUpdate: (date) {
                  controller.updateCurrentDate(date);
                })
            ],
          ),
          Expanded(
            child: WidgetLoadMoreRefresh(
              controller: _.refreshController,
              onLoadMore: _.getMaintenanceSchedule,
              onRefresh: _.onRefresh,
              isNotEmpty: _.maintenanceSchedule.isNotEmpty,
              child: _.loading.value
                  ? const WidgetLoading()
                  : SingleChildScrollView(
                child: WidgetListMaintenanceSchedule(controller: controller),
              ),
            ),
          )
        ],
      );
    });
  }
  Widget _buildCalendars({
    required DateTime fromDate,
    required DateTime toDate,
    required Function(DateTime) onUpdate
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Column(
        children: [
          TableCalendar(
            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
              onUpdate.call(selectedDay);
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
                            color: AppColor.black,
                            fontFamily: Fonts.Quicksand.name,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    UIIconButton(
                      child: RotatedBox(
                        quarterTurns: controller.showCalendar.value ? 1 : 3,
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
    return GetX<RepairController>(builder: (_) {
      return ListView.builder(
          itemCount: controller.maintenanceSchedule.length,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return itemBuilder(controller.maintenanceSchedule, index);
          });
    });
  }



  Widget itemBuilder(List<dynamic> data, int index) {
    MaintenanceScheduleEntity entity = data[index];
    return WidgetItemRepair(entity: entity, onPressed: () async{
      final _ = await Get.toNamed(Routes.repairDetail , arguments: entity);
      if(_ != null && _) {
        controller.onRefresh();
      }
    });
  }

}
