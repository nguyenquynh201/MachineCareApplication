import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/ui/ui.dart';

class StringUtils {
  static bool isEmpty(String? s) {
    if (s == null) return true;
    if (s.trim().isEmpty) return true;
    return false;
  }
  static String getDifferenceTimeString({
    required String dateStr,
  }) {
    final DateTime date = DateTime.parse(dateStr);
    final int inDays = DateTime.now().difference(date).inDays;

    if (inDays > DateTime.daysPerWeek) {
      return getDateStrings(dateStr);
    }

    if (inDays != 0) {
      return "$inDays ngày trước";
    }

    final int inHours = DateTime.now().difference(date).inHours;

    if (inHours != 0) {
      return "$inHours giờ trước";
    }

    final int inMinutes = DateTime.now().difference(date).inMinutes;

    if (inMinutes != 0) {
      return "$inMinutes phút trước";
    }

    return "Ngay bây giờ";
  }
  static String getDateString(String dateStr) {
    final DateTime date = DateTime.parse(dateStr);
    return "${date.year}/${_twoDigits(date.month)}/${_twoDigits(date.day)}";
  }

  static String getDateStrings(String dateStr) {
    final DateTime date = DateTime.parse(dateStr);
    return "${date.day}/${_twoDigits(date.month)}/${_twoDigits(date.year)}";
  }

  static String getTimeString(String dateStr) {
    final DateTime date = DateTime.parse(dateStr);
    return DateFormat('hh:mm a').format(date);
  }

  static String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }
  //InvalidPhoneState
  static String toInvalidPhoneString(ValidatePhoneState state) {
    switch (state) {
      case ValidatePhoneState.invalid:
        return "Số điện thoại không hợp lệ";
      case ValidatePhoneState.notCorrect:
        return "Không tìm thấy số điện thoại";
      case ValidatePhoneState.duplicate:
        return "Số điện thoại đã tồn tại";
      case ValidatePhoneState.none:
      default:
        return "";
    }
  }

  static String toErrorTimeString(CompareTimeState state) {
    switch (state) {
      case CompareTimeState.invalid:
        return "Thời gian không hợp lệ!";
      case CompareTimeState.none:
      default:
        return "";
    }
  }

  static String toInvalidPasswordString(ValidatePasswordState state) {
    switch (state) {
      case ValidatePasswordState.invalid:
        return "Mật khẩu tối thiểu 6 ký tự có cả số , chữ hoa, chữ thường và ký tự đặc biệt";
      case ValidatePasswordState.notCorrect:
        return "Mật khẩu không trùng khớp";
      case ValidatePasswordState.none:
      default:
        return "";
    }
  }

  static String targetMachineType({TargetMachine? targetMachine}) {
    switch (targetMachine) {
      case TargetMachine.frequent:
        return 'frequent'.tr;
      case TargetMachine.maintenance:
        return 'maintenance'.tr;
      default:
        return 'frequent'.tr;
    }
  }
  static String statusValueOf(StatusEnum? status) {
    switch (status) {
      case StatusEnum.Cancel:
        return "cancel".tr;
      case StatusEnum.Waiting:
        return "waiting".tr;
      case StatusEnum.Coming:
        return "coming".tr;
      case StatusEnum.Done:
        return "done".tr;
      case StatusEnum.Received:
        return "received".tr;
      default:
        return "waiting".tr;
    }
  }
  static Color statusTypeColor(StatusEnum status) {
    switch (status) {
      case StatusEnum.Coming:
        return HexColor.fromHex("#0BA5EC");
      case StatusEnum.Waiting:
        return HexColor.fromHex("#F79009");
      case StatusEnum.Done:
        return HexColor.fromHex("#12B76A");
      case StatusEnum.Cancel:
        return HexColor.fromHex("#F04438");
      case StatusEnum.Received:
        return HexColor.fromHex("#F04438");
      default:
        return HexColor.fromHex("#0BA5EC");
    }
  }

  static Color statusColor(String status) {
    switch (status) {
      case "coming":
        return HexColor.fromHex("#0BA5EC");
      case "waiting":
        return HexColor.fromHex("#F79009");
      case "done":
        return HexColor.fromHex("#12B76A");
      case "cancel":
        return HexColor.fromHex("#F04438");
      case "received":
        return HexColor.fromHex("#F04438");
      default:
        return HexColor.fromHex("#0BA5EC");
    }
  }
}
