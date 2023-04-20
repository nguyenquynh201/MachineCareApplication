import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:machine_care/constants/app_colors.dart';
import 'package:machine_care/constants/app_images.dart';
import 'package:machine_care/constants/app_text_styles.dart';
import 'package:machine_care/utils/string_utils.dart';
import 'package:machine_care/utils/utils.dart';

import '../ui.dart';

class CreateEditAddressScreen extends BaseScreen<CreateEditAddressController> {
  CreateEditAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WidgetLoadingFullScreen<CreateEditAddressController>(
        child: Scaffold(
          backgroundColor: AppColor.primary,
          body: Column(
            children: [
              WidgetHeader(
                title: 'add_address_new'.tr,
                color: AppColor.primary,
                colorIcon: AppColor.black,
              ),
              Expanded(child: _buildBody())
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return GetX<CreateEditAddressController>(builder: (_) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 21),
        decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius:
                BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _.updateFixed();
                },
                child: Row(
                  children: [
                    UICheckboxButton(
                      size: 18,
                      selected: _.isFixed.value,
                      borderRadius: 5,
                      color: AppColor.colorCheckBox,
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    Text(
                      'fixed'.tr,
                      style: AppTextStyles.customTextStyle().copyWith(
                          color: AppColor.colorButton,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: Fonts.Quicksand.name),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              WidgetItemAddress(
                title: 'name'.tr.toUpperCase(),
                des: 'obligatory'.tr,
                child: _buildInput(
                    controller: _.nameController,
                    typeInput: TypeInput.custom,
                    hint: 'hint_name'.tr,
                    onChanged: _.onChangedName),
              ),
              WidgetItemAddress(
                title: 'phone'.tr.toUpperCase(),
                des: 'obligatory'.tr,
                child: _buildInput(
                  controller: _.phoneController,
                  hint: 'hint_phone'.tr,
                  errorMessage: StringUtils.toInvalidPhoneString(_.validatePhone.value),
                  textInputType: TextInputType.number,
                  onChanged: _.onChangedPhone,
                ),
              ),
              _buildRadioButtonGroup(),
              const SizedBox(
                height: 20,
              ),
              WidgetItemAddress(
                title: 'province'.tr.toUpperCase(),
                des: 'obligatory'.tr,
                child: _buildAddressProvinceInput(),
              ),
              WidgetItemAddress(
                title: 'district'.tr.toUpperCase(),
                des: 'obligatory'.tr,
                child: _buildAddressDistrictInput(),
              ),
              WidgetItemAddress(
                title: 'address'.tr.toUpperCase(),
                des: 'obligatory'.tr,
                child: _buildInput(
                  controller: _.addressController,
                  typeInput: TypeInput.custom,
                  hint: 'hint_address'.tr,
                  onChanged: _.onChangedAddress,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              WidgetButton(
                title: 'create_address'.tr,
                enabled: _.enable.value,
                onPressed: _.createAddress,
                typeButton: TypeButton.none,
                padding: const EdgeInsets.symmetric(vertical: 20),
              )
            ],
          ),
        ),
      );
    });
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
              loadingBuilder: (_) => const WidgetLoading() ,
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
              loadingBuilder: (_) => const WidgetLoading() ,
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

class WidgetItemAddress extends StatelessWidget {
  const WidgetItemAddress({Key? key, required this.title, this.des, required this.child})
      : super(key: key);
  final String title;
  final String? des;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitle(title: title, des: des),
        const SizedBox(
          height: 10,
        ),
        child
      ],
    );
  }

  Widget _buildTitle({required String title, String? des}) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.customTextStyle().copyWith(
              fontFamily: Fonts.Quicksand.name,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.black),
        ),
        const SizedBox(
          width: 13,
        ),
        if (des != null)
          Text(
            des,
            style: AppTextStyles.customTextStyle().copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.primary,
                fontStyle: FontStyle.italic,
                fontFamily: Fonts.Quicksand.name),
          )
      ],
    );
  }
}
