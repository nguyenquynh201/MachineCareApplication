import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:machine_care/constants/app_colors.dart';
import 'package:machine_care/constants/app_images.dart';


class UIRadioButton extends StatelessWidget {
  final double size;
  final bool selected;
  final bool isSize;
  const UIRadioButton({
    Key? key,
    required this.size,
    this.selected = false,
    this.isSize = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return Container(
        height: (isSize == true) ? size + 10 : size,
        width:  (isSize == true) ? size + 10 : size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size),
          color: AppColor.colorCheckbox,
        ),
        child: SvgPicture.asset(
          AppImages.iconCheck,
          height:  (isSize == true) ? size + 10 : size ,
          width:  (isSize == true) ? size + 10 : size,
        ),
      );
    }
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.lineColor),
        borderRadius: BorderRadius.circular(size / 2),
      ),
    );
  }
}
