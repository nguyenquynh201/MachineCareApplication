import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/model/model.dart';

import '../ui.dart';
class WidgetHeaderHome extends StatelessWidget {
  const WidgetHeaderHome({Key? key, required this.user}) : super(key: key);
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: AppColor.primary,
      child: Padding(
        padding: EdgeInsets.only(
            top: Get.mediaQuery.viewPadding.top + 18, left: 24, right: 24, bottom: 12),
        child: Row(
          children: [
            const WidgetAvatar(
              radius: 24,
            ),
            const SizedBox(
              width: 11,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "HI , ${user.fullName}",
                  style: AppTextStyles.customTextStyle().copyWith(
                      fontSize: 10,
                      color: AppColor.colorButton,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  "welcome".tr,
                  style: AppTextStyles.customTextStyle().copyWith(
                      fontSize: 12,
                      color: AppColor.colorButton,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            const Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: WidgetSvg(
                    path: AppImages.icNotification,
                    height: 27,
                    width: 24,
                    fit: BoxFit.contain,
                    color: AppColor.colorButton,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
