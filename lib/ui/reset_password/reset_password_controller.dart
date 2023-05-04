import 'package:flutter/cupertino.dart';
import 'package:machine_care/resources/network_state.dart';

import '../../utils/utils.dart';
import '../ui.dart';

class ResetPasswordController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }

  Rx<String> currentPassword = "".obs;
  Rx<String> newPassword = "".obs;
  Rx<String> rePassword = "".obs;
  RxBool oldPassword = true.obs;
  RxBool securePassword = true.obs;
  RxBool secureRePassword = true.obs;
  Rx<ValidatePasswordState> oldPasswordState = ValidatePasswordState.none.obs;
  Rx<ValidatePasswordState> passwordState = ValidatePasswordState.none.obs;
  Rx<ValidatePasswordState> rePasswordState = ValidatePasswordState.none.obs;

  void onChangeOldPassword(String value) {
    currentPassword.value = value.trim();
    if (Validators.isValidPassword(currentPassword.value)) {
      oldPasswordState.value = ValidatePasswordState.none;
    }
  }

  void onChangeNewPassword(String value) {
    newPassword.value = value.trim();
    if (Validators.isValidPassword(newPassword.value)) {
      passwordState.value = ValidatePasswordState.none;
    }
  }

  void updateOldPassword() {
    oldPassword.value = !oldPassword.value;
  }

  void updateSecurePassword() {
    securePassword.value = !securePassword.value;
  }

  void updateSecureRePassword() {
    secureRePassword.value = !secureRePassword.value;
  }

  void onChangeRePassword(String value) {
    rePassword.value = value.trim();
    if (newPassword.isEmpty) {
      rePasswordState.value = ValidatePasswordState.none;
    } else {
      if (rePassword != newPassword) {
        rePasswordState.value = ValidatePasswordState.notCorrect;
      } else {
        rePasswordState.value = ValidatePasswordState.none;
      }
    }
  }

  RxBool get enable {
    return (!StringUtils.isEmpty(newPassword.value) &&
            !StringUtils.isEmpty(rePassword.value) &&
            !StringUtils.isEmpty(currentPassword.value))
        .obs;
  }

  void handleValidatePassword({
    VoidCallback? onSuccess,
    VoidCallback? onError,
  }) async {
    if (!Validators.isValidPassword(newPassword.value)) {
      passwordState.value = ValidatePasswordState.invalid;
      return;
    } else {
      passwordState.value = ValidatePasswordState.none;
    }
    if (newPassword != rePassword) {
      rePasswordState.value = ValidatePasswordState.notCorrect;
      return;
    } else {
      rePasswordState.value = ValidatePasswordState.none;
    }
    if (!Validators.isValidPassword(rePassword.value)) {
      rePasswordState.value = ValidatePasswordState.invalid;
      return;
    } else {
      rePasswordState.value = ValidatePasswordState.none;
    }
    passwordState.value = ValidatePasswordState.none;
    rePasswordState.value = ValidatePasswordState.none;
    oldPasswordState.value = ValidatePasswordState.none;
    try {
      setLoading(true);
      if (Get.arguments != null) {
        NetworkState state = await appRepository.resetPassword(
            id: (Get.arguments as UserEntity).sId ?? "",
            currentPassword: currentPassword.value,
            newPassword: newPassword.value);
        if (state.isSuccess && state.data != null) {
          setLoading(false);
          if (onSuccess != null) {
            onSuccess.call();
          }
        }else {
          setLoading(false);
          if (onError != null) {
            onError.call();
          }
        }
      } else {
        setLoading(false);
        if (onError != null) {
          onError.call();
        }
      }
    } catch (e) {
      setLoading(false);
      AppUtils.logMessage(e.toString());
      if (onError != null) {
        onError.call();
      }
    }
  }
}
