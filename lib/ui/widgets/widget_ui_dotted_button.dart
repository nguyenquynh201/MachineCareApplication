import 'package:flutter/material.dart';
import 'package:machine_care/constants/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';

class UIDottedButton extends StatelessWidget {
  final EdgeInsets padding;
  final Color? backgroundColor;
  final BorderType borderType;
  final double strokeWidth;
  final Radius radius;
  final Widget child;

  UIDottedButton({
    Key? key,
    required this.child,
    required this.borderType,
    required this.strokeWidth,
    required this.radius,
    this.padding = EdgeInsets.zero,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: [4, 4],
      padding: padding,
      borderType: borderType,
      strokeWidth: strokeWidth,
      color: AppColor.colorTitleHome,
      strokeCap: StrokeCap.round,
      radius: radius,
      child: child,
    );
  }
}
