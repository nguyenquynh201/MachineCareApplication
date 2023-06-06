import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/routers/app_routes.dart';

import '../ui.dart';

class AddressScreen extends BaseScreen<AddressController> {
  AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        children: [
          WidgetHeader(
            title: 'address_book'.tr,
            isBackground: true,
          ),
          const SizedBox(
            height: 20,
          ),
          WidgetItemProfile(
              title: 'add_address_new'.tr,
              icon: AppImages.iconAddLocation,
              color: AppColor.colorSupport,
              onPress: () async {
                final _ = await Get.toNamed(Routes.createEditAddress);
                if (_ != null && _) {
                  controller.onRefresh();
                }
              }),
          Expanded(
            child: GetX<AddressController>(
              builder: (_) {
                return WidgetLoadMoreRefresh(
                  controller: _.refreshController,
                  onLoadMore: _.getAddress,
                  onRefresh: _.onRefresh,
                  isNotEmpty: _.address.isNotEmpty,
                  child: _.loading.value
                      ? const WidgetLoading()
                      : SingleChildScrollView(
                          child: WidgetLocation(
                            controller: _,
                            addressList: (_.address),
                          ),
                        ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class WidgetLocation extends StatelessWidget {
  const WidgetLocation({Key? key, required this.addressList, required this.controller})
      : super(key: key);
  final List addressList;
  final AddressController controller;

  @override
  Widget build(BuildContext context) {
    return GetX<AddressController>(builder: (_) {
      return ListView.builder(
          itemCount: addressList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            UserAddress entity = addressList.elementAt(index);
            return WidgetAddress(
              entity: entity,
              onPressed: () async {
                final _ = await Get.toNamed(Routes.createEditAddress, arguments: entity);
                if ( _ != null && _) {
                  controller.onRefresh();
                }
              },
            );
          });
    });
  }
}
