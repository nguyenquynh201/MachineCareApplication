import 'dart:io';

import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:machine_care/utils/utils.dart';

class InformationController extends BaseController {
  Rx<File> avatar = File('').obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  Rx<TextEditingController> provinceController = TextEditingController().obs;
  Rx<TextEditingController> districtController = TextEditingController().obs;
  TextEditingController addressController = TextEditingController();
  final Rx<Gender> _gender = Gender.male.obs;

  Rx<Gender> get gender => _gender;
  RxList<ProvinceEntity> provinceEntity = <ProvinceEntity>[].obs;
  Rx<ProvinceEntity>? addressCity;
  String idProvince = "";
  RxList<DistrictEntity> districtEntity = <DistrictEntity>[].obs;
  Rx<DistrictEntity>? addressDistrict;
  Rx<ValidatePhoneState> validatePhone = ValidatePhoneState.none.obs;

  RxString name = "".obs;
  RxString phone = "".obs;
  RxString address = "".obs;

  @override
  void onInit() async {
    super.onInit();
    if (AppPref.user.sId != null) {
      entity.value = AppPref.user;
      print("nè nè ${AppPref.user.avatar}");
    } else {
      await getUser();
    }
    _register();
  }
  _register() {
    nameController.text = entity.value.fullName ?? EndPoint.EMPTY_STRING;
    phoneController.text = entity.value.phone ?? EndPoint.EMPTY_STRING;
    provinceController.value.text = entity.value.addressProvince ?? EndPoint.EMPTY_STRING;
    districtController.value.text = entity.value.addressDistrict ?? EndPoint.EMPTY_STRING;
    addressController.text = entity.value.address ?? EndPoint.EMPTY_STRING;
    gender.value = entity.value.gender ?? Gender.female;
  }
  Rx<UserEntity> entity = UserEntity().obs;

  Future getUser() async {
    setLoading(true);
    NetworkState state = await appRepository.getMyProfile();
    if (state.isSuccess && state.data != null) {
      setLoading(false);
      entity.value = state.data as UserEntity;
      AppPref.user = entity.value;
    } else {
      setLoading(false);
      AppUtils.showToast('load_api_fail'.tr);
    }
  }
  void onChangeGender(Gender gender) {
    _gender.value = gender;
  }

  void onChangedName(String value) {
    name.value = value;
    AppUtils.logMessage(value);
  }


  void onChangedAddress(String value) {
    address.value = value;
    AppUtils.logMessage(value);
  }

  Future<List<ProvinceEntity>> getProvince(
      String? search,
      ) async {
    NetworkState state = await appRepository.getProvince(search: search!);
    if (state.isSuccess && state.data != null) {
      provinceEntity.value = state.data as List<ProvinceEntity>;
    }
    return provinceEntity;
  }

  void onChangedAddressCity(ProvinceEntity value) {
    addressCity?.value = value;
    idProvince = value.sId!;
    AppUtils.logMessage(value.name ?? "khong co province");
    getDistrict(value.sId!);
  }

  void resetAddressCity() {
    addressCity = null;
  }

  Future<List<DistrictEntity>> getDistrict(
      String? search,
      ) async {
    NetworkState state = await appRepository.getDistrict(search: search!, idProvince: idProvince);
    if (state.isSuccess && state.data != null) {
      districtEntity.value = state.data as List<DistrictEntity>;
    }
    return districtEntity;
  }

  void onChangedAddressDistrict(DistrictEntity value) {
    addressDistrict?.value = value;
    AppUtils.logMessage(value.name ?? "khong co district");
  }

  void resetAddressDistrict() {
    addressDistrict = null;
  }
}
