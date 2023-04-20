import 'package:flutter/material.dart';
import '../../utils/utils.dart';
import '../ui.dart';

class WidgetImageFrame extends StatelessWidget {
  final VoidCallback? onTap;
  final String? profileImageLink;
  final String? frameUrl;
  final double? radius;
  final double? size;
  final double? border;
  final Color? borderColor;

  const WidgetImageFrame({
    Key? key,
    this.onTap,
    this.profileImageLink,
    this.frameUrl,
    this.radius,
    this.size,
    this.border = 0,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(width: size ?? 68.r, height: size ?? 68.r),
          WidgetAvatar(
              borderColor: borderColor,
              border: border,
              onTap: onTap,
              radius: radius ?? 22.r,
              url: profileImageLink ?? ""),
          Visibility(
              visible: frameUrl != null ,
              child: WidgetImageNetwork(
                  placeHolderType: PlaceHolderType.typeNothing,
                  radius: radius ?? 22.r,
                  url: frameUrl ?? "",
                  width: size ?? 68.r,
                  height: size ?? 68.r)),
        ],
      ),
    );
  }
}
