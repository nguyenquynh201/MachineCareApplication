import 'package:machine_care/enum/validate.dart';
import 'package:machine_care/resources/model/model.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/routers/app_routes.dart';
import 'package:machine_care/utils/app_pref.dart';
import 'package:machine_care/utils/app_utils.dart';
import 'package:machine_care/utils/string_utils.dart';

import '../ui.dart';

class LoginController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }

  Rx<String> phoneNumber = "".obs;
  Rx<String> password = "".obs;
  Rx<bool> obscureText = false.obs;
  Rx<bool> onErrorPhone = false.obs;
  Rx<bool> onErrorPassword = false.obs;
  ValidatePhoneState _validatePhoneState = ValidatePhoneState.none;

  ValidatePhoneState get validatePhoneState => _validatePhoneState;

  void onChangedPhoneNumber(String value) {
    phoneNumber.value = value;
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
    setLoading(true);
    try {
      NetworkState state =
          await appRepository.login(phoneNumber.value.toString(), password.value.trim());
      if (state.isSuccess && state.data != null) {
        AppPref.token = state.data;
        NetworkState userProfile = await appRepository.getMyProfile();
        if (userProfile.isSuccess && userProfile.data != null) {
          AppPref.user = userProfile.data;
          print("hihi ${(userProfile.data as UserEntity).resetPassword!}");
          if (!(userProfile.data as UserEntity).resetPassword!) {
            Get.toNamed(Routes.resetPassword, arguments: userProfile.data);
          } else {
            Get.toNamed(Routes.information, arguments: userProfile.data);
          }
          AppUtils.showToast('login_success'.tr);
        }
      }
      setLoading(false);
    } catch (e) {
      setLoading(false);
      AppUtils.showToast(e.toString());
    }
  }

  Rx<bool> get enable {
    print(
        "nè nè ${_validatePhoneState == ValidatePhoneState.none && _validatePasswordState == ValidatePasswordState.none && !StringUtils.isEmpty(phoneNumber.value.toString()) && !StringUtils.isEmpty(password.value)}");
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
