import 'dart:ui';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:machine_care/ui/create_edit_address/widget/widget.dart';
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
    return GetX<InformationController>(
      builder: (_) {
        return SizedBox(
          child: Stack(
            children: [
              _WidgetBackgroundBlur(headerHeight: 400, avatarUrl: AppPref.user.avatar ?? ''),
              Positioned(
                bottom: 1,
                top: 100,
                child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: const BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
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
                          title: 'email'.tr.toUpperCase(),
                          des: 'obligatory'.tr,
                          child: _buildInput(
                              controller: _.emailController,
                              typeInput: TypeInput.custom,
                              hint: 'hint_email'.tr,
                              onChanged: _.onChangedEmail),
                        ),
                        WidgetItemAddress(
                          title: 'phone'.tr.toUpperCase(),
                          des: 'obligatory'.tr,
                          child: _buildInput(
                            controller: _.phoneController,
                            hint: 'hint_phone'.tr,
                            enable: false,
                            errorMessage: StringUtils.toInvalidPhoneString(_.validatePhone.value),
                            textInputType: TextInputType.number,
                          ),
                        ),
                        WidgetItemAddress(
                          title: 'birth'.tr.toUpperCase(),
                          des: '',
                          child: _buildInput(
                            controller: _.birthDayController.value,
                            // hint: 'hint_phone'.tr,
                            bgColor: AppColor.white,
                            enable: false,
                            typeInput: TypeInput.custom,
                            hint: "dd-MM-yyyy",
                            onRightIconPressed: () async {
                              final String? result = await controller.pickDateOfBirth(Get.context!);
                              if (result == null) return;
                              _.birthDayController.value.text = result;
                            },
                            iconRight: Container(
                              color: AppColor.white,
                              padding: const EdgeInsets.all(10),
                              child: WidgetSvg(
                                path: AppImages.icCalendar,
                                width: 18,
                                height: 18,
                                color: HexColor.fromHex("#C1C1C7"),
                                fit: BoxFit.contain,
                              ),
                            ),
                            textInputType: TextInputType.number,
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
                          title: 'update_info'.tr,
                          enabled: _.enable.value,
                          onPressed: _.updateInfo,
                          typeButton: TypeButton.none,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              _buildAvatar(),
            ],
          ),
        );
      },
    );
  }

  _buildAvatar() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: () async {
          final _ = await Get.bottomSheet(const DialogUploadImage());
          if (_ != null) {
            controller.avatar.value = _;
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            GetX<InformationController>(builder: (_) {
              return Stack(
                children: [
                  if (_.avatar.value.path != '')
                    CircleAvatar(
                      maxRadius: 50.r,
                      backgroundImage: FileImage(_.avatar.value),
                    )
                  else
                    WidgetAvatar(
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
                    ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 27,
                      height: 27,
                      decoration:
                          const BoxDecoration(shape: BoxShape.circle, color: AppColor.colorEdit),
                      child: const Center(
                        child: WidgetSvg(
                          path: AppImages.iconEdit,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioButtonGroup() {
    return Obx(() => Column(
          children: [
            Row(
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
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                UIRadioTitle(
                  title: 'other'.tr,
                  value: Gender.other,
                  groupValue: controller.gender.value,
                  onChanged: (value) {
                    controller.onChangeGender(value);
                  },
                  icon: AppImages.iconMale,
                ),
              ],
            )
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
      VoidCallback? onRightIconPressed,
      bool enable = true,
      Widget? iconRight,
      Color? bgColor,
      bool isReasonable = false}) {
    return WidgetInput(
      bgColor: bgColor,
      controller: controller,
      errorMessage: errorMessage,
      onChanged: onChanged,
      onFocus: onFocus,
      typeInput: typeInput,
      hint: hint,
      enable: enable,
      keyboardType: textInputType,
      isReasonable: isReasonable,
      onRightIconPressed: onRightIconPressed,
      iconRight: iconRight,
    );
  }
}

class _WidgetBackgroundBlur extends StatelessWidget {
  final double headerHeight;
  final String avatarUrl;

  const _WidgetBackgroundBlur({
    Key? key,
    required this.headerHeight,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: headerHeight,
      child: Stack(
        fit: StackFit.loose,
        children: [
          KeyedSubtree(
              key: UniqueKey(),
              child: WidgetImageNetwork(
                  url: avatarUrl,
                  height: headerHeight,
                  width: Get.width,
                  fit: BoxFit.cover,
                  placeHolderType: PlaceHolderType.coverBackground)),
          BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(color: Colors.grey.withOpacity(0.1), alignment: Alignment.center)),
          Container(height: headerHeight, color: AppColor.black.withOpacity(0.25))
        ],
      ),
    );
  }
}
