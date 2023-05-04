import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/ui/ui.dart';

class StringUtils {
  static bool isEmpty(String? s) {
    if (s == null) return true;
    if (s.trim().isEmpty) return true;
    return false;
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
      case "new":
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
