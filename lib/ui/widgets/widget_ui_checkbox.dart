import 'package:flutter/material.dart';
import 'package:machine_care/constants/app_colors.dart';
import 'package:machine_care/constants/app_images.dart';
import 'package:machine_care/ui/ui.dart';

class UICheckboxButton extends StatelessWidget {
  final double size;
  final double borderRadius;
  final bool selected;
  final Color? color;
  const UICheckboxButton({
    Key? key,
    required this.size,
    required this.borderRadius,
    this.selected = false, this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius / 2),
          color: color ?? AppColor.colorCheckbox,
        ),
        child: WidgetSvg(
           path:AppImages.iconCheck,
          height: size,
          width: size,
          color: AppColor.white,
        ),
      );
    }
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.primary),
        borderRadius: BorderRadius.circular(borderRadius / 2),
      ),
    );
  }
}
