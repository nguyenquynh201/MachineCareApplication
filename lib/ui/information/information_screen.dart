import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:machine_care/utils/utils.dart';
import '../ui.dart';

class InformationScreen extends BaseScreen<InformationController> {
  InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetLoadingFullScreen<InformationController>(
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: Column(
          children: [
            WidgetHeader(
              title: 'information'.tr,
              isBackground: true,
            ),
            Expanded(child: _buildBody())
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildAvatar(),
        Positioned(
          bottom: 1,
          child: Container(

            width: Get.width,
            decoration: const BoxDecoration(
                color: AppColor.white,
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: Column(
              children: [

              ],
            ),
          ),
        )
      ],
    );
  }

  _buildAvatar() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: () async {
          final _ = await Get.bottomSheet(const DialogUploadImage());
          if (_ != null) {
            controller.avatar.value = _;
          }
        },
        child: Stack(
          children: [
            GetX<InformationController>(builder: (_) {
              if (_.avatar.value.path != '') {
                return CircleAvatar(
                  maxRadius: 50.r,
                  backgroundImage: FileImage(_.avatar.value),
                );
              }
              return WidgetAvatar(
                onTap: () async {
                  final _ = await Get.bottomSheet(const DialogUploadImage());
                  if (_ != null) {
                    controller.avatar.value = _;
                  }
                },
                border: 2,
                borderColor: Colors.white,
                radius: 50.r,
                url: AppPref.user.avatar,
              );
            }),
            Positioned(
              bottom: 2,
              right: 2,
              child: Container(
                width: 27,
                height: 27,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.colorEdit
                ),
                child: const Center(
                  child: WidgetSvg(
                    path: AppImages.iconEdit,
                    color: AppColor.white,
                  ),
                ),
              ),

            )
          ],
        ),
      ),
    );
  }

  Widget _buildRadioButtonGroup() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UIRadioTitle(
              title: 'male'.tr,
              value: Gender.male,
              groupValue: controller.gender.value,
              onChanged: (value) {
                controller.onChangeGender(value);
              },
              icon: AppImages.iconMale,
            ),
            const SizedBox(
              width: 20,
            ),
            UIRadioTitle(
              title: 'female'.tr,
              value: Gender.female,
              groupValue: controller.gender.value,
              onChanged: (value) {
                controller.onChangeGender(value);
              },
              icon: AppImages.iconFemale,
            ),
          ],
        ));
  }

  Widget _buildAddressProvinceInput() {
    return Obx(() => Container(
          padding: const EdgeInsets.only(
            bottom: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.white,
          ),
          child: TypeAheadField<ProvinceEntity?>(
              hideSuggestionsOnKeyboardHide: true,
              textFieldConfiguration: TextFieldConfiguration(
                style: AppTextStyles.customTextStyle().copyWith(
                    fontSize: 14,
                    height: 1.25,
                    fontWeight: FontWeight.w600,
                    fontFamily: Fonts.Quicksand.name,
                    color: AppColor.colorTitleHome),
                controller: controller.provinceController.value,
                autocorrect: false,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primary),
                  ),
                  hintText: 'hint_province'.tr,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primary),
                  ),
                  hintStyle: TextStyle(
                      fontSize: 14,
                      height: 1.25,
                      color: AppColor.primary,
                      fontFamily: Fonts.Quicksand.name,
                      fontWeight: FontWeight.w600),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primary),
                  ),
                  contentPadding: const EdgeInsets.only(top: 14, bottom: 14, left: 28),
                  isCollapsed: true,
                ),
              ),
              onSuggestionSelected: (ProvinceEntity? pattern) {
                controller.provinceController.value.text = pattern!.name!;
                controller.districtController.value.clear();
                controller.resetAddressDistrict();
                controller.onChangedAddressCity(pattern);
              },
              itemBuilder: (context, ProvinceEntity? item) {
                return ListTile(title: Text(item!.name!));
              },
              loadingBuilder: (_) => const WidgetLoading(),
              noItemsFoundBuilder: (context) => Center(
                    child: Text(
                      'notFoundProvince'.tr,
                      style: AppTextStyles.customTextStyle().copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: Fonts.Quicksand.name,
                          color: AppColor.black),
                    ),
                  ),
              suggestionsCallback: controller.getProvince),
        ));
  }

  Widget _buildAddressDistrictInput() {
    return Obx(() => Container(
          padding: const EdgeInsets.only(
            bottom: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.white,
          ),
          child: TypeAheadField<DistrictEntity?>(
              hideSuggestionsOnKeyboardHide: true,
              textFieldConfiguration: TextFieldConfiguration(
                style: AppTextStyles.customTextStyle().copyWith(
                    fontSize: 14,
                    height: 1.25,
                    fontWeight: FontWeight.w600,
                    fontFamily: Fonts.Quicksand.name,
                    color: AppColor.colorTitleHome),
                controller: controller.districtController.value,
                autocorrect: false,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primary),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primary),
                  ),
                  hintText: 'hint_district'.tr,
                  hintStyle: TextStyle(
                      fontSize: 14,
                      height: 1.25,
                      color: AppColor.primary,
                      fontFamily: Fonts.Quicksand.name,
                      fontWeight: FontWeight.w600),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primary),
                  ),
                  contentPadding: const EdgeInsets.only(top: 14, bottom: 14, left: 28),
                  isCollapsed: true,
                ),
              ),
              loadingBuilder: (_) => const WidgetLoading(),
              onSuggestionSelected: (DistrictEntity? pattern) {
                controller.districtController.value.text = pattern!.name!;
                controller.onChangedAddressDistrict(pattern);
              },
              itemBuilder: (context, DistrictEntity? item) {
                return ListTile(title: Text(item!.name!));
              },
              noItemsFoundBuilder: (context) => Center(
                    child: Text(
                      'notFoundDistrict'.tr,
                      style: AppTextStyles.customTextStyle().copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: Fonts.Quicksand.name,
                          color: AppColor.black),
                    ),
                  ),
              suggestionsCallback: controller.getDistrict),
        ));
  }

  Widget _buildInput(
      {required TextEditingController controller,
      String? errorMessage,
      String? hint,
      Function(String)? onChanged,
      Function()? onFocus,
      TypeInput typeInput = TypeInput.none,
      TextInputType textInputType = TextInputType.text,
      bool isReasonable = false}) {
    return WidgetInput(
      controller: controller,
      errorMessage: errorMessage,
      onChanged: onChanged,
      onFocus: onFocus,
      typeInput: typeInput,
      hint: hint,
      keyboardType: textInputType,
      isReasonable: isReasonable,
    );
  }
}
