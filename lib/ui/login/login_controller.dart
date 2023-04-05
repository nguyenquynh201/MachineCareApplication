import 'package:machine_care/enum/validate.dart';
import 'package:machine_care/utils/string_utils.dart';

import '../ui.dart';

class LoginController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }

  Rx<int> phoneNumber = 0.obs;
  Rx<String> password = "".obs;
  Rx<bool> obscureText = false.obs;
  Rx<bool> onErrorPhone = false.obs;
  Rx<bool> onErrorPassword = false.obs;
  ValidatePhoneState _validatePhoneState = ValidatePhoneState.none;

  ValidatePhoneState get validatePhoneState => _validatePhoneState;

  void onChangedPhoneNumber(String value) {
    phoneNumber.value = int.parse(value);
    if (value.trim().isEmpty) {
      _validatePhoneState = ValidatePhoneState.none;
      onErrorPhone.value = false;
    }
    if ((value.trim().length < 10 && value.trim().isNotEmpty) || value.trim().length > 11) {
      _validatePhoneState = ValidatePhoneState.invalid;
      onErrorPhone.value = true;
    } else {
      _validatePhoneState = ValidatePhoneState.none;
      onErrorPhone.value = false;
    }
  }

  void onSubmittedPhone(String value) {
    if (value.length < 10 || value.length > 10) {
      _validatePhoneState = ValidatePhoneState.invalid;
      onErrorPhone.value = true;
    } else {
      _validatePhoneState = ValidatePhoneState.none;
      onErrorPhone.value = false;
    }
  }

  ValidatePasswordState _validatePasswordState = ValidatePasswordState.none;

  ValidatePasswordState get validatePasswordState => _validatePasswordState;
  void onChangedPassword(String value) {
    password.value = value;
    if (value.isEmpty) {
      _validatePasswordState = ValidatePasswordState.invalid;
      onErrorPassword.value = true;
    } else {
      _validatePasswordState = ValidatePasswordState.none;
      onErrorPassword.value = false;
    }
  }

  void onLogin() async {

  }
  Rx<bool> get enable {
    print("nè nè ${_validatePhoneState == ValidatePhoneState.none &&
        _validatePasswordState == ValidatePasswordState.none &&
        !StringUtils.isEmpty(phoneNumber.value.toString()) &&
        !StringUtils.isEmpty(password.value)}");
    return (_validatePhoneState == ValidatePhoneState.none &&
            _validatePasswordState == ValidatePasswordState.none &&
            !StringUtils.isEmpty(phoneNumber.value.toString()) &&
            !StringUtils.isEmpty(password.value))
        .obs;
  }

  void updateObscureText() {
    obscureText.value = !obscureText.value;
  }
}
