import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:machine_care/constants/constants.dart';
import '../ui.dart';

enum AvatarType { user, project }

class WidgetAvatar extends StatelessWidget {
  final double radius;
  final String? url;
  final double? border;
  final Color? borderColor;
  final Widget? error;
  final AvatarType? type;
  final VoidCallback? onTap;
  final PlaceHolderType? placeHolderType;

  const WidgetAvatar(
      {Key? key,
        required this.radius,
        this.url,
        this.onTap,
        this.border = 0,
        this.borderColor,
        this.error,
        this.type = AvatarType.user,
        this.placeHolderType = PlaceHolderType.avatar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (border == null || border == 0) return _buildCircleAvatar();
    return CircleAvatar(
        radius: radius,
        backgroundColor: borderColor ?? AppColor.primary,
        child: _buildCircleAvatar());
  }

  _buildCircleAvatar() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap ?? () {},
      child: KeyedSubtree(
        key: UniqueKey(),
        child: url != null
            ? CircleAvatar(
            backgroundColor: AppColor.primary,
            radius: radius - border!,
            child: ClipOval(
              child: WidgetImageNetwork(
                url: url ?? "",
                width: radius * 2,
                height: radius * 2,
                fit: BoxFit.fill,
                placeHolderType: placeHolderType,
              ),
            ))
            : CircleAvatar(
          radius: radius - border!,
          child: ClipOval(
            child: SvgPicture.asset(
              AppImages.icNoAvatar,
              width: 50,
              height: 50,
            ),
          ),
        ),
      ),
    );
  }
}
