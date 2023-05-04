import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/utils/app_utils.dart';

class Validators {
  Validators._();

  static bool isEmpty(String? s) {
    if(s == null) return true;
    return s == EndPoint.EMPTY_STRING;
  }

  static bool isEmail(String email) {

    if (isEmpty(email)) {
      return false;
    }

    final emailRegexp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegexp.hasMatch(email);
  }
  static bool isSpecialChartPassword(String password) {
    if (isEmpty(password)) {
      return false;
    }
    final validCharacters = RegExp(r'^[a-zA-Z0-9@]+$');
    return validCharacters.hasMatch(password);
  }
  static bool isValidPassword(String password) {
    if (isEmpty(password)) {
      return false;
    }
    if(password.length < 6){
      return password.length >= EndPoint.MINIMUM_PASSWORD_LENGTH;
    }

    final passRegexp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    AppUtils.logMessage("${passRegexp.hasMatch(password)}");
    return passRegexp.hasMatch(password) && password.length >= EndPoint.MINIMUM_PASSWORD_LENGTH ;

    // final RegExp passwordRegexp =
    //     RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");
    // final RegExp passwordRegexp = RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$");
    // final RegExp passwordRegexp = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$");
    // return passwordRegexp.hasMatch(password) &&
    //     password.length > Constants.MINIMUM_PASSWORD_LENGTH;
    // return password.length >= Constants.MINIMUM_PASSWORD_LENGTH;
  }

  static bool isValidPhone(String phone) {

    if (isEmpty(phone)) {
      return false;
    }
    return phone.length >= EndPoint.MINIMUM_PHONE_LENGTH;
  }
}
