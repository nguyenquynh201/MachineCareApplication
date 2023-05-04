import 'package:flutter/material.dart';
import 'package:machine_care/constants/app_colors.dart';
import 'package:machine_care/ui/ui.dart';
class Indicator extends StatelessWidget {
  final DateTime dayOfWeek;
  final String typeCalendar;
  final RepairController controller;
  final Function(int)? callBack;
  const Indicator(
      {Key? key,
        required this.dayOfWeek,
        required this.typeCalendar, this.callBack, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _loadIndicator();
  }

  Widget _loadIndicator() {

    if (typeCalendar == "Order") {
      // LogUtils.methodIn(message: typeCalendar);
      return GetX<RepairController>(
        builder: (_) {
          bool isDate = false;
          // for (var date in viewModel.allOrders) {
          //   if ((date.startedDate!.microsecondsSinceEpoch <=
          //       dayOfWeek.microsecondsSinceEpoch) &&
          //       (date.endedDate!.microsecondsSinceEpoch >=
          //           dayOfWeek.microsecondsSinceEpoch) || (checkDate(date.startedDate!, date.endedDate!, dayOfWeek)) ) {
          //     isDate = true;
          //     break;
          //   }
          //
          //   // LogUtils.methodIn(message: "$index");
          //   // LogUtils.methodIn(message: "${date.startedDate!.isAfter(dayOfWeek)}");
          //   // LogUtils.methodIn(message: "${dayOfWeek.isAfter(date.endedDate!)}");
          // }


          if (isDate == true) {
            return Container(
              height: 4,
              width: 4,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColor.primary),
            );
          } else {
            return Container();
          }
        },
      );
    }

    return Container();
  }

  bool checkDate(DateTime startTime, DateTime endTime, DateTime forgetTime) {
    if (((startTime.year <= endTime.year)) &&
        ((startTime.month <= endTime.month)) &&
        ((startTime.day <= endTime.day))) {
      if ((startTime.year == forgetTime.year ) &&
          (startTime.month == forgetTime.month) &&
          (startTime.day == forgetTime.day)) {
        return true;
      }
    }
    return false;
  }
}