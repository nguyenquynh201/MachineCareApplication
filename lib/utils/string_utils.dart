import 'package:machine_care/enum/validate.dart';

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

  static String toInvalidPasswordString(ValidatePasswordState state) {
    switch (state) {
      case ValidatePasswordState.invalid:
        return "Invalid password";
      case ValidatePasswordState.notCorrect:
        return "Password not matching";
      case ValidatePasswordState.none:
      default:
      return "";
    }
  }
}