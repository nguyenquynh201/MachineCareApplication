import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/model/product_entity.dart';
import '../../ui.dart';

class WidgetItemProduct extends StatelessWidget {
  const WidgetItemProduct({Key? key, required this.entity}) : super(key: key);
  final ProductEntity entity;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primary,
      child: Stack(
        children: [
          Positioned(
              top: -70,
              left: -50,
              child: Container(
                width: 180,
                height: 180,
                decoration:
                BoxDecoration(shape: BoxShape.circle, gradient: AppColor.getGradientPrimary),
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              _buildProductImage(images: entity.imageMachine),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.only(left: 14 , right: 14 , bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entity.nameMaintenance ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.customTextStyle().copyWith(
                          color: AppColor.colorButton,
                          fontSize: 18,
                          fontFamily: Fonts.Quicksand.name,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${"serial".tr}: ${entity.serialNumber.toString()}",
                      style: AppTextStyles.customTextStyle().copyWith(
                          color: AppColor.colorTitleHome,
                          fontSize: 12,
                          fontFamily: Fonts.Quicksand.name,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      )
      ,
    );
  }

  Widget _buildProductImage({List<FileEntity>? images}) {
    if (images == null || images.isEmpty) {
      return const WidgetImageAsset(
        url: AppImages.iconMachine,
        width: 120,
        fit: BoxFit.cover,
        height: 120,
      );
    }
    return (images
        .elementAt(0)
        .url != null) ? WidgetImageNetwork(
        url: images
            .elementAt(0)
            .url ?? "",
        width: 120,
        height: 120,
        placeHolderType: PlaceHolderType.typeNothing) : const WidgetImageAsset(
      url: AppImages.iconMachine,
      width: 120,
      fit: BoxFit.cover,
      height: 120,
    );
  }
}
