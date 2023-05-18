import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:machine_care/constants/app_colors.dart';
import 'package:machine_care/constants/app_text_styles.dart';
import '../ui.dart';


class UIInputComment extends StatelessWidget {
  final String? hint;
  final bool isRequired;
  final bool enabled;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final VoidCallback? onRightIconPressed;
  final VoidCallback? onFocus;
  final OnChanged? onChanged;
  final OnSubmit? onSubmitted;
  final Widget? iconRight;
  final String? unit;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  const UIInputComment({
    Key? key,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onRightIconPressed,
    this.onFocus,
    this.isRequired = true,
    this.enabled = true,
    this.iconRight,
    this.unit,
    this.inputFormatters,
    this.textInputAction,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor.white,
        border: Border.all(color: AppColor.lineColor),
      ),
      padding: const EdgeInsets.only(
          left: 16,
          right: 4),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: TextField(
                  maxLines: maxLines,
                  onTap: onFocus,
                  controller: controller,
                  inputFormatters: inputFormatters,
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                  style: AppTextStyles.customTextStyle().copyWith(
                    fontSize: 14,
                    height: 1.25,
                    fontFamily: Fonts.Quicksand.name,
                    color: AppColor.colorButton
                  ),
                  obscureText: obscureText,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    enabled: enabled,
                    hintStyle:  AppTextStyles.customTextStyle().copyWith(
                        fontSize: 14,
                        height: 1.25,
                        fontFamily: Fonts.Quicksand.name,
                      color: AppColor.description
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    isCollapsed: true,
                  ),
                  keyboardType: keyboardType,
                  textInputAction: textInputAction,
                ),
              ),
            ),
          ),
          if (iconRight != null)
            Material(
              color: AppColor.white,
              borderRadius:
              BorderRadius.circular(20),
              child: InkWell(
                  borderRadius:
                  BorderRadius.circular(20),
                  onTap: onRightIconPressed,
                  child: iconRight),
            ),

        ],
      ),
    );
  }
}
