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
            crossAxisCount: 2, childAspectRatio: 0.96),
        itemBuilder: (_, index) {
          return itemBuilder(controller.products, index);
        });
  }

  Widget itemBuilder(List<dynamic> data, int index) {
    return WidgetItemProduct(entity: data[index].productId);
  }
}
