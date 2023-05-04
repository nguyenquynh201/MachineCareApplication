import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';

import '../../ui.dart';
class WidgetAddress extends StatelessWidget {
  const WidgetAddress({Key? key, required this.entity, this.onPressed , this.isHide = false}) : super(key: key);
  final UserAddress entity;
  final VoidCallback? onPressed;
  final bool isHide;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: isHide ? AppColor.white : AppColor.colorBgProfile,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                WidgetSvg(
                  path: AppImages.iconLocation,
                  height: 24,
                  width: 24,
                  color: (entity.fixed ?? false)
                      ? AppColor.colorFeedback
                      : AppColor.colorSupport,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 35),
                  margin: const EdgeInsets.only(left: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColor.white,
                      border: Border.all(color: AppColor.colorButton, width: 1)),
                  child: Text(
                    entity.nameAddress ?? "",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.customTextStyle().copyWith(
                        fontSize: 10,
                        color: AppColor.colorButton,
                        fontWeight: FontWeight.w500,
                        fontFamily: Fonts.Quicksand.name),
                  ),
                ),
                Visibility(
                  visible: !isHide,
                  child: Expanded(
                    child: Text(
                      'edit'.tr,
                      textAlign: TextAlign.right,
                      style: AppTextStyles.customTextStyle().copyWith(
                          fontFamily: Fonts.Quicksand.name,
                          color: AppColor.colorSupport,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entity.nameAddress ?? "",
                  style: AppTextStyles.customTextStyle().copyWith(
                      fontFamily: Fonts.Quicksand.name,
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  entity.phone ?? "",
                  style: AppTextStyles.customTextStyle().copyWith(
                      fontFamily: Fonts.Quicksand.name,
                      color: AppColor.colorTitleHome,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "${entity.nameAddress} - ${entity.addressDistrict} - ${entity.addressProvince}",
                  textAlign: TextAlign.right,
                  style: AppTextStyles.customTextStyle().copyWith(
                      fontFamily: Fonts.Quicksand.name,
                      color: AppColor.colorTitleHome,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
                const SizedBox(
                  height: 3,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
