import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import '../ui.dart';
class WidgetPerson extends StatelessWidget {
  const   WidgetPerson({Key? key, required this.entity, required this.onPressed}) : super(key: key);
  final UserEntity entity;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
      BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildThumbnail(url: entity.avatar),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: _buildBasicInfo(
                        customerName: entity.fullName ?? "",
                        mailAddress: entity.email ?? "",
                        phoneNumber: entity.phone ?? ""))
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget _buildBasicInfo({
    required String customerName,
    required mailAddress,
    required String phoneNumber,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 220),
          child: Text(
            customerName,
            style: AppTextStyles.customTextStyle().copyWith(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppColor.colorTitleHome,
                fontFamily: Fonts.Quicksand.name),
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildIcon(
              iconName: AppImages.iconCalling,
              size: 14,
            ),
            const SizedBox(width: 8),
            _buildInformationTitle(data: phoneNumber),
          ],
        ),
      ],
    );
  }

  Widget _buildInformationTitle({required String data}) {
    return Text(
      data,
      style: AppTextStyles.customTextStyle().copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColor.description,
          fontFamily: Fonts.Quicksand.name),
    );
  }

  Widget _buildIcon({required String iconName, double? size}) {
    return SizedBox(
      height: size ?? 40,
      width: size ?? 40,
      child: WidgetSvg(path: iconName, fit: BoxFit.contain),
    );
  }

  Widget _buildThumbnail({String? url}) {
    if (url != null) {
      return WidgetImageNetwork(
          url: url,
          width: 40,
          height: 40,
          borderRadius: BorderRadius.circular(12),
          placeHolderType: PlaceHolderType.typeNothing);
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
