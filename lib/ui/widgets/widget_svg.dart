import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:machine_care/constants/app_colors.dart';

class WidgetSvg extends StatelessWidget {
  const WidgetSvg(
      {Key? key,
      this.width,
      this.height,
      required this.path,
      this.fit = BoxFit.cover,
      this.color,
      this.isColor = false})
      : super(key: key);
  final double? width;
  final double? height;
  final String path;
  final BoxFit fit;
  final Color? color;
  final bool isColor;
  @override
  Widget build(BuildContext context) {
    if (isColor) {
      return SvgPicture.asset(
        path,
        alignment: Alignment.bottomCenter,
        width: width ?? 13,
        height: height ?? 13,
        fit: fit,
      );
    }
    return SvgPicture.asset(
      path,
      alignment: Alignment.bottomCenter,
      width: width ?? 13,
      height: height ?? 13,
      color: color ?? AppColor.primary,
      fit: fit,
    );
  }
}
