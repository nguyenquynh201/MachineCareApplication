import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/utils/utils.dart';

import '../ui.dart';

class WidgetItemProfile extends StatelessWidget {
  const WidgetItemProfile({Key? key, this.user, required this.title, this.color, this.onPress, required this.icon}) : super(key: key);
  final UserEntity? user;
  final String title;
  final Color? color ;
  final VoidCallback? onPress ;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: Get.width,
        color: AppColor.colorBgProfile,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        child: user != null
            ? Row(
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
                  user?.fullName ?? AppPref.user.fullName ?? 'noName'.tr,
                  style: AppTextStyles.customTextStyle().copyWith(
                      fontFamily: Fonts.Quicksand.name,
                      color: AppColor.colorButton,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  user?.phone ?? AppPref.user.phone!,
                  style: AppTextStyles.customTextStyle().copyWith(
                      fontFamily: Fonts.Quicksand.name,
                      color: AppColor.colorTitleHome,
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                )
              ],
            )
          ],
        )
            : Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Center(child: WidgetSvg(path: icon , width: 18 , height: 18,color: AppColor.white,)),

            ),
            const SizedBox(width: 17,),
            Expanded(
              child: Text(title , style: AppTextStyles.customTextStyle().copyWith(
                  color: AppColor.colorButton,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: Fonts.Quicksand.name
              ),),
            ),
            const WidgetSvg(path: AppImages.icNext , fit: BoxFit.contain,width: 24, height: 24,)
          ],
        ),
      ),
    );
  }
}
