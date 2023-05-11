import 'dart:io';

import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/utils/utils.dart';
import '../ui.dart';

class LoginScreen extends BaseScreen<LoginController> {
  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (DateTime.now().millisecondsSinceEpoch - controller.lastClickBack < 1000 * 3) {
          exit(0);
        } else {
          controller.lastClickBack = DateTime.now().millisecondsSinceEpoch;
          AppUtils.showToast('msg_info_back_to_close_app'.tr);
        }
        return false;
      },
      child: WidgetLoadingFullScreen<LoginController>(
        child: Scaffold(
          backgroundColor: AppColor.primary,
          body: Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: Get.mediaQuery.viewPadding.top + 12),
                    margin: const EdgeInsets.symmetric(horizontal: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          height: 27,
                          decoration: BoxDecoration(
                              color: AppColor.colorButton, borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: [
                              Text(
                                'vn'.tr,
                                style: AppTextStyles.customTextStyle().copyWith(
                                  fontFamily: 'Roboto',
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const WidgetSvg(
                                path: AppImages.iconVietNam,
                                height: 18,
                                width: 18,
                                isColor: true,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  WidgetImageAsset(
                    url: AppImages.iconMachine,
                    width: Get.width,
                    fit: BoxFit.cover,
                    height: 324,
                  ),
                  GetX<LoginController>(
                      builder: (_) => Container(
                            width: Get.width,
                            padding: const EdgeInsets.only(right: 33, left: 33, top: 30),
                            decoration: const BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'descriptionLogin'.tr,
                                  style: AppTextStyles.customTextStyle().copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.black),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  'titleLogin'.tr,
                                  style: AppTextStyles.customTextStyle().copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: AppColor.black),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                WidgetInput(
                                  hint: 'number_phone'.tr,
                                  keyboardType: TextInputType.number,
                                  onSubmitted: _.onSubmittedPhone,
                                  onChanged: _.onChangedPhoneNumber,
                                  errorMessage: _.onErrorPhone.value
                                      ? StringUtils.toInvalidPhoneString(_.validatePhoneState)
                                      : "",
                                ),
                                WidgetInput(
                                  hint: 'password'.tr,
                                  keyboardType: TextInputType.visiblePassword,
                                  typeInput: TypeInput.custom,
                                  obscureText: _.obscureText.value,
                                  onChanged: _.onChangedPassword,
                                  onRightIconPressed: _.updateObscureText,
                                  errorMessage: _.onErrorPassword.value
                                      ? StringUtils.toInvalidPasswordString(_.validatePasswordState)
                                      : "",
                                ),
                                WidgetButton(
                                  title: 'continue'.tr,
                                  backgroundColor: AppColor.colorButton,
                                  enabled: _.enable.value,
                                  onPressed: () {
                                    _.onLogin();
                                  },
                                  typeButton: TypeButton.custom,
                                ),
                                const SizedBox(
                                  height: 26,
                                ),
                                Center(
                                  child: Text(
                                    'other_login'.tr,
                                    style: AppTextStyles.customTextStyle().copyWith(
                                        fontSize: 10, color: AppColor.black.withOpacity(0.5)),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      WidgetSocial(
                                          path: AppImages.iconGoogle,
                                          onPressed: () {},
                                          height: 24,
                                          width: 24),
                                      Visibility(
                                          visible: Platform.isIOS,
                                          child: const SizedBox(
                                            width: 46,
                                          )),
                                      Visibility(
                                        visible: Platform.isIOS,
                                        child: WidgetSocial(
                                            path: AppImages.iconApple,
                                            onPressed: () {},
                                            height: 24,
                                            width: 24),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WidgetSocial extends StatelessWidget {
  const WidgetSocial(
      {Key? key,
      required this.path,
      required this.onPressed,
      required this.height,
      required this.width})
      : super(key: key);
  final String path;
  final VoidCallback onPressed;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 63,
        height: 41,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.primary, width: 1)),
        child: Center(
          child: WidgetSvg(
            path: path,
            height: height,
            width: width,
            fit: BoxFit.contain,
            isColor: true,
          ),
        ),
      ),
    );
  }
}
