import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetSvg extends StatelessWidget {
  const WidgetSvg({Key? key, this.width, this.height, required this.path, this.fit = BoxFit.cover})
      : super(key: key);
  final double? width;
  final double? height;
  final String path;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      alignment: Alignment.bottomCenter,
      width: width ?? 13,
      height: height ?? 13,
      fit: fit,
    );
  }
}
