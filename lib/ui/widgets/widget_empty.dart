import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:machine_care/constants/constants.dart';
import '../ui.dart';

class WidgetEmpty extends StatelessWidget {
  final String? text;
  final String? description;
  final double? height;
  final String? image;
  final String? title;
  final String? button;
  final VoidCallback? buttonClick;
  final TextStyle? textStyle;

  const WidgetEmpty(
      {Key? key,
        this.text = "",
        this.description = "",
        this.height,
        this.image,
        this.title,
        this.textStyle,
        this.button,
        this.buttonClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: height == null ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        SizedBox(height: height ?? 0),
        SvgPicture.asset(
          image == null ? AppImages.emptyViewNew : image.toString(),
        ),
        const SizedBox(height: 10),
        Visibility(
            visible: title != null,
            child: Column(
              children: [
                Text(
                  title.toString(),
                  style: AppTextStyles.verySmallBold(),
                ),
                const SizedBox(height: 6),
              ],
            )),
        Visibility(
            visible: text != null,
            child: Column(
              children: [
                Text(
                  text.toString().isEmpty ? 'no_data'.tr : text.toString(),
                  style: textStyle ?? AppTextStyles.verySmall().copyWith(color: AppColor.primary),
                ),
                const SizedBox(height: 6),
              ],
            )),
        Visibility(
          visible: description.toString().isNotEmpty,
          child: Text(
            description.toString(),
            style:
            AppTextStyles.customTextStyle().copyWith(color: AppColor.primary, fontSize: 13),
          ),
        ),
        Visibility(
            visible: button != null,
            child: GestureDetector(
              onTap: buttonClick,
              child: Text(
                button ?? "",
                style: AppTextStyles.customTextStyle().copyWith(
                  color: AppColor.colorButton,
                  fontSize: 13.sp,
                  decoration: TextDecoration.underline,
                ),
              ),
            )),
      ],
    );
  }
}
