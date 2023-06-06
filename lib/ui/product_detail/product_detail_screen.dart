import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/model/product_entity.dart';
import 'package:machine_care/utils/utils.dart';
import '../ui.dart';

class ProductDetailScreen extends BaseScreen<ProductDetailController> {
  ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetLoadingFullScreen<ProductDetailController>(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColor.colorBanner,
          body: Column(
            children: [
              WidgetHeader(
                title: 'product_detail'.tr,
                isBackground: true,
              ),
              Expanded(child: _buildBody())
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Obx(() {
      if (controller.entity.value.productId == null) {
        return const WidgetEmpty();
      }
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 24, bottom: 24, left: 15, right: 15),
          child: Column(
            children: [
              WidgetImage(
                image: controller.entity.value.productId?.imageMachine ?? [],
              ),
              _buildProductInfo(entity: controller.entity.value.productId!),
              _buildProductDate(entity: controller.entity.value)
            ],
          ),
        ),
      );
    });
  }

  Widget _buildProductInfo({required ProductEntity entity}) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.white,
      ),
      child: Column(
        children: [
          _buildUnitInfos(title: 'name_product'.tr, des: entity.nameMaintenance ?? ""),
          _buildUnitInfos(title: 'serial_number'.tr, des: entity.serialNumber ?? ""),
          _buildUnitInfos(title: 'manufacturer'.tr, des: entity.manufacturer ?? ""),
          _buildUnitInfos(
              title: 'year_manufacturer'.tr,
              des: StringUtils.getDateStrings(entity.yearOfManufacturer.toString())),
        ],
      ),
    );
  }

  Widget _buildProductDate({required ProductUserEntity entity}) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.white,
      ),
      child: Column(
        children: [
          _buildUnitInfos(
              title: 'last_maintenance_date'.tr,
              des: StringUtils.getDateStrings(entity.lastMaintenanceDate.toString())),
          _buildUnitInfos(
              title: 'next_maintenance_date'.tr,
              des: StringUtils.getDateStrings(entity.nextMaintenanceDate.toString())),
        ],
      ),
    );
  }

  Widget _buildUnitInfos({required String title, required String des, String? focus}) {
    return Container(
        padding: const EdgeInsets.only(
          top: 8,
          left: 16,
          right: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColor.white,
        ),
        child: _buildTextInfor(title: title, des: des, focus: focus));
  }

  Widget _buildTextInfor({required String title, required String des, String? focus}) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildTitleInput(title: title, focus: focus), _buildDes(des: des)],
      ),
    );
  }

  Widget _buildTitleInput({required String title, String? focus}) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.customTextStyle().copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColor.colorTitleHome,
              fontFamily: Fonts.Quicksand.name),
        ),
        const SizedBox(
          width: 8,
        ),
        if (!StringUtils.isEmpty(focus))
          Text(
            focus!,
            style: AppTextStyles.customTextStyle().copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColor.borderError,
                fontFamily: Fonts.Quicksand.name),
          ),
      ],
    );
  }

  Widget _buildDes({required String des}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: 4,
          ),
          child: Text(
            des,
            style: AppTextStyles.customTextStyle().copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColor.colorTitleHome,
                fontFamily: Fonts.Quicksand.name),
          ),
        ),
        const Divider(
          thickness: 1,
          color: AppColor.lineColor,
        )
      ],
    );
  }
}

class WidgetImage extends StatelessWidget {
  final double? padding;
  final double? radius;
  final List<FileEntity> image;

  const WidgetImage({Key? key, this.padding, this.radius, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = 138;
    return Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
        child: image.isEmpty
            ? WidgetImageAsset(
                url: AppImages.bannerDefault,
                width: Get.width,
                fit: BoxFit.contain,
                height: height,
              )
            : CarouselSlider(
                items: List.generate(
                    image.length,
                    (index) => GestureDetector(
                        onTap: () {},
                        child: WidgetImageNetwork(
                            width: Get.width,
                            radius: radius ?? 20,
                            height: height,
                            fit: BoxFit.cover,
                            url: image[index].url ?? "",
                            placeHolderType: PlaceHolderType.typeBanner))),
                options: CarouselOptions(
                  height: height,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 500),
                  scrollDirection: Axis.horizontal,
                ),
              ));
  }
}
