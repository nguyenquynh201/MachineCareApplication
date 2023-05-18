import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/ui/ui.dart';

class WidgetThumbnail extends StatelessWidget {
  const WidgetThumbnail({Key? key, this.url}) : super(key: key);
  final String? url;

  @override
  Widget build(BuildContext context) {
    if (url != null) {
      return WidgetImageNetwork(
          url: url!,
          width: 40,
          height: 40,
          borderRadius: BorderRadius.circular(12),
          placeHolderType: PlaceHolderType.avatar);
    }
    return WidgetImageNetwork(
        url: AppImages.icNoAvatar,
        width: 40,
        fit: BoxFit.cover,
        height: 40,
        borderRadius: BorderRadius.circular(12),
        placeHolderType: PlaceHolderType.avatar);
  }
}
