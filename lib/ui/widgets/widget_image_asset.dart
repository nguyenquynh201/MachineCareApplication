import 'package:flutter/cupertino.dart';

class WidgetImageAsset extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final int? cacheWidth;
  final int? cacheHeight;
  final Color? color;
  final BorderRadius? borderRadius;
  final double? radius;
  const WidgetImageAsset(
      {Key? key,
        required this.url,
        this.width,
        this.height,
        this.fit,
        this.color,
        this.cacheWidth,
        this.cacheHeight, this.borderRadius, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? cacheWidthTemp = cacheWidth;
    int? cacheHeightTemp = cacheHeight;
    if (height != double.infinity) {
      cacheHeightTemp =
      height != null ? (height! * MediaQuery.of(context).devicePixelRatio).round() : null;
    }
    if (width != double.infinity) {
      cacheWidthTemp =
      width != null ? (width! * MediaQuery.of(context).devicePixelRatio).round() : null;
    }
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0),
      child: Image.asset(
        url,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        color: color,
        cacheWidth: cacheWidthTemp,
        cacheHeight: cacheHeightTemp,
      ),
    );
  }
}