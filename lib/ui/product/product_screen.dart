import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/ui/ui.dart';

class ProductScreen extends BaseScreen<ProductController> {
  ProductScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        children: [
          WidgetHeader(
            title: 'product_me'.tr,
            leading: Container(),
          ),
          Expanded(child: GetX<ProductController>(
            builder: (_) {
              return WidgetLoadMoreRefresh(
                controller: _.refreshController,
                onLoadMore: _.getProduct,
                onRefresh: _.onRefresh,
                child: _.loading.value
                    ? const WidgetLoading()
                    : SingleChildScrollView(
                        child: WidgetListProduct(controller: _),
                      ),
              );
            },
          ))
        ],
      ),
    );
  }
}

class WidgetListProduct extends StatelessWidget {
  const WidgetListProduct({Key? key, required this.controller}) : super(key: key);
  final ProductController controller;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: controller.products.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.89, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (_, index) {
          return itemBuilder(controller.products, index);
        });
  }

  Widget itemBuilder(List<dynamic> data, int index) {
    return Container(
      color: AppColor.primary,
      child: Stack(
        clipBehavior: Clip.antiAlias,
        fit: StackFit.expand,
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
              data[index].productId?.imageMachine.isNotEmpty
                  ? WidgetImageNetwork(
                      url: data[index].productId?.imageMachine?.first.url ?? "",
                      width: 120,
                      height: 120,
                      placeHolderType: PlaceHolderType.typeNothing)
                  : const WidgetImageAsset(
                      url: AppImages.iconMachine,
                      width: 120,
                      fit: BoxFit.cover,
                      height: 120,
                    ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.only(left: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data[index].productId?.nameMaintenance ?? "",
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
                      "${"serial".tr}: ${data[index].productId?.serialNumber.toString()}",
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
      ),
    );
  }
}
