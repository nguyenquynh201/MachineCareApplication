import 'package:flutter/material.dart';
import 'package:machine_care/constants/app_colors.dart';
import 'package:machine_care/constants/app_images.dart';
import 'package:machine_care/constants/app_text_styles.dart';
import 'package:machine_care/ui/ui.dart';

typedef OnChanged = Function(String);
typedef OnSubmit = Function(String);

class WidgetInput extends StatelessWidget {
  const WidgetInput(
      {Key? key,
      this.hint = "",
      this.errorMessage,
      this.obscureText = false,
      this.maxLength,
      this.keyboardType = TextInputType.text,
      this.controller,
      this.onRightIconPressed,
      this.onFocus,
      this.onChanged,
      this.onSubmitted,
      this.typeInput = TypeInput.none,
      this.iconRight,
      this.isReasonable = false,
      this.enable = true,
      this.bgColor})
      : super(key: key);
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final int? maxLength;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final VoidCallback? onRightIconPressed;
  final VoidCallback? onFocus;
  final OnChanged? onChanged;
  final OnSubmit? onSubmitted;
  final TypeInput typeInput;
  final bool isReasonable;
  final Widget? iconRight;
  final bool enable;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: !enable ? (bgColor ?? AppColor.colorBanner) : Colors.transparent,
            border: Border.all(
              color: (errorMessage == null || errorMessage!.isEmpty)
                  ? AppColor.primary
                  : AppColor.borderError,
            ),
          ),
          padding: const EdgeInsets.only(left: 16, right: 4),
          child: Row(
            children: [
              Visibility(
                visible: typeInput == TypeInput.none,
                child: Row(
                  children: [
                    const WidgetSvg(
                      path: AppImages.iconVietNam,
                      height: 18,
                      width: 18,
                      fit: BoxFit.contain,
                      isColor: true,
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      "+84",
                      style: AppTextStyles.customTextStyle().copyWith(
                          fontSize: 14, fontWeight: FontWeight.w400, color: AppColor.black),
                    ),
                    const SizedBox(
                      width: 21,
                    ),
                    Container(
                      width: 1,
                      height: 34,
                      color: AppColor.primary,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 46,
                  padding: const EdgeInsets.only(left: 12, top: 5, bottom: 5),
                  child: MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: TextField(
                      onTap: onFocus,
                      controller: controller,
                      onChanged: onChanged,
                      onSubmitted: onSubmitted,
                      style: TextStyle(
                          fontSize: 14,
                          height: 1.25,
                          fontWeight: FontWeight.w600,
                          fontFamily: Fonts.Quicksand.name,
                          color: AppColor.colorTitleHome),
                      textAlignVertical: TextAlignVertical.center,
                      obscureText: obscureText,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        enabled: enable,
                        hintStyle: TextStyle(
                            fontSize: 14,
                            height: 1.25,
                            color: AppColor.primary,
                            fontFamily: Fonts.Quicksand.name,
                            fontWeight: FontWeight.w600),
                      ),
                      keyboardType: keyboardType,
                    ),
                  ),
                ),
              ),
              if (iconRight != null)
                Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: onRightIconPressed,
                        child: iconRight)),
              if (keyboardType == TextInputType.visiblePassword)
                Material(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: onRightIconPressed,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: WidgetSvg(
                        path: (obscureText) ? AppImages.iconEyeOff : AppImages.iconEyeOn,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ),
              // if (isReasonable == true)
              //   Material(
              //     color: AppColor.primary,
              //     borderRadius: BorderRadius.circular(20),
              //     child: InkWell(
              //       borderRadius: BorderRadius.circular(20),
              //       onTap: onRightIconPressed,
              //       child: Container(
              //         padding: const EdgeInsets.all(10),
              //         child: const WidgetSvg(
              //           path: AppImages.iconVietNam,
              //         ),
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
        if (!(errorMessage == null || errorMessage!.isEmpty))
          Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              errorMessage!,
              style: TextStyle(
                color: AppColor.borderError,
                fontSize: 13,
              ),
            ),
          ),
        if (errorMessage == null || errorMessage!.isEmpty) SizedBox(height: 20),
      ],
    );
  }
}

enum TypeInput { none, custom }
