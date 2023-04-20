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
          Expanded(
            child: GetX<AddressController>(
              builder: (_) {
                return WidgetLoadMoreRefresh(
                  controller: _.refreshController,
                  onLoadMore: _.getAddress,
                  onRefresh: _.onRefresh,
                  child: _.loading.value
                      ? const WidgetLoading()
                      : WidgetLocation(
                          addressList: (_.address),
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
  const WidgetLocation({Key? key, required this.addressList}) : super(key: key);
  final List addressList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            itemCount: addressList.length,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              UserAddress entity = addressList.elementAt(index);
              return GestureDetector(
                onTap: () async {
                  final _ = await Get.toNamed(Routes.createEditAddress , arguments: entity);
                  if (_ != null && _) {}
                },
                child: Container(
                  color: AppColor.colorBgProfile,
                  padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          WidgetSvg(
                            path: AppImages.iconLocation,
                            height: 24,
                            width: 24,
                            color: (entity.fixed ?? false)
                                ? AppColor.colorFeedback
                                : AppColor.colorSupport,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 35),
                            margin: const EdgeInsets.only(left: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.white,
                                border: Border.all(color: AppColor.colorButton, width: 1)),
                            child: Text(
                              entity.nameAddress ?? "",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.customTextStyle().copyWith(
                                  fontSize: 10,
                                  color: AppColor.colorButton,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: Fonts.Quicksand.name),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'edit'.tr,
                              textAlign: TextAlign.right,
                              style: AppTextStyles.customTextStyle().copyWith(
                                  fontFamily: Fonts.Quicksand.name,
                                  color: AppColor.colorSupport,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entity.nameAddress ?? "",
                            style: AppTextStyles.customTextStyle().copyWith(
                                fontFamily: Fonts.Quicksand.name,
                                color: AppColor.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            entity.phone ?? "",
                            style: AppTextStyles.customTextStyle().copyWith(
                                fontFamily: Fonts.Quicksand.name,
                                color: AppColor.colorTitleHome,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "${entity.nameAddress} - ${entity.addressDistrict} - ${entity.addressProvince}",
                            textAlign: TextAlign.right,
                            style: AppTextStyles.customTextStyle().copyWith(
                                fontFamily: Fonts.Quicksand.name,
                                color: AppColor.colorTitleHome,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          const SizedBox(
                            height: 3,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
        const SizedBox(
          height: 47,
        ),
        WidgetItemProfile(
            title: 'add_address_new'.tr,
            icon: AppImages.iconAddLocation,
            color: AppColor.colorSupport,
            onPress: () async {
              final _ = await Get.toNamed(Routes.createEditAddress);
              if (_ != null && _) {}
            }),
      ],
    );
  }
}
