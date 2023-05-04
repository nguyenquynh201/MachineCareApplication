import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/routers/app_routes.dart';
import 'package:machine_care/utils/utils.dart';
import '../ui.dart';

class ResetPasswordScreen extends BaseScreen<ResetPasswordController> {
  ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetLoadingFullScreen<ResetPasswordController>(
      child: Scaffold(
          backgroundColor: AppColor.white,
          body: Column(
            children: [
              WidgetHeader(
                title: 'reset_password',
                centerTitle: true,
                isBackground: true,
                leading: Container(),
              ),
              _buildBody()
            ],
          )),
    );
  }

  Widget _buildBody() {
    return GetX<ResetPasswordController>(builder: (_) {
      return Expanded(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: [
                WidgetInput(
                  hint: 'old_password'.tr,
                  keyboardType: TextInputType.visiblePassword,
                  typeInput: TypeInput.custom,
                  obscureText: _.oldPassword.value,
                  onChanged: _.onChangeOldPassword,
                  onRightIconPressed: _.updateOldPassword,
                  errorMessage: StringUtils.toInvalidPasswordString(_.oldPasswordState.value),
                ),
                WidgetInput(
                  hint: 'new_password'.tr,
                  keyboardType: TextInputType.visiblePassword,
                  typeInput: TypeInput.custom,
                  obscureText: _.securePassword.value,
                  onChanged: _.onChangeNewPassword,
                  onRightIconPressed: _.updateSecurePassword,
                  errorMessage: StringUtils.toInvalidPasswordString(_.passwordState.value),
                ),
                WidgetInput(
                  hint: 'renew_password'.tr,
                  keyboardType: TextInputType.visiblePassword,
                  typeInput: TypeInput.custom,
                  obscureText: _.secureRePassword.value,
                  onChanged: _.onChangeRePassword,
                  onRightIconPressed: _.updateSecureRePassword,
                  errorMessage: StringUtils.toInvalidPasswordString(_.rePasswordState.value),
                ),
                const SizedBox(
                  height: 40,
                ),
                WidgetButton(
                  title: 'continue'.tr,
                  backgroundColor: AppColor.colorButton,
                  enabled: _.enable.value,
                  onPressed: () {
                    _.handleValidatePassword(onSuccess: () {
                      AppUtils.showToast('password_reset_success'.tr);
                      Get.toNamed(Routes.mainNavigation);
                    }, onError: () {
                      AppUtils.showToast('password_reset_fail'.tr);
                    });
                  },
                  typeButton: TypeButton.none,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
