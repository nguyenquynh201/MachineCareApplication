import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:machine_care/utils/utils.dart';

class InformationController extends BaseController {
  Rx<File> avatar = File('').obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  Rx<TextEditingController> birthDayController = TextEditingController().obs;
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
  RxString address = "".obs;
  DateTime _birthday = DateTime.now();

  DateTime get birthday => _birthday;

  @override
  void onInit() async {
    super.onInit();
    setLoading(true);
    if (AppPref.user.sId != null) {
      entity.value = AppPref.user;
    } else {
      await getUser();
    }
    _register();
    setLoading(false);

  }

  _register() {
    nameController.text = name.value = entity.value.fullName ?? EndPoint.EMPTY_STRING;
    phoneController.text = entity.value.phone ?? EndPoint.EMPTY_STRING;
    provinceController.value.text = entity.value.addressProvince ?? EndPoint.EMPTY_STRING;
    districtController.value.text = entity.value.addressDistrict ?? EndPoint.EMPTY_STRING;
    addressController.text = address.value = entity.value.address ?? EndPoint.EMPTY_STRING;
    _birthday = (!StringUtils.isEmpty(entity.value.birthday)
        ? DateTime.tryParse(entity.value.birthday!)
        : DateTime.now()) ?? DateTime.now();
    birthDayController.value = TextEditingController(
      text: DateFormat("dd-MM-yyyy").format(_birthday),
    );
    gender.value = entity.value.gender ?? Gender.female;
  }

  Rx<UserEntity> entity = UserEntity().obs;

  Future getUser() async {
    NetworkState state = await appRepository.getMyProfile();
    if (state.isSuccess && state.data != null) {
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

  RxBool get enable {
    return (!StringUtils.isEmpty(name.value)).obs;
  }

  void updateInfo() async {
    setLoading(true);

    if(avatar.value.path.isNotEmpty) {
      await appRepository.uploadImage(
          idUser: entity.value.sId ?? AppPref.user.sId ?? "", file: avatar.value);
    }
    if (checkEditInfo()) {
      UserEntity entity = UserEntity(
        fullName: name.value,
        phone: phoneController.value.text,
        gender: _gender.value,
        addressProvince: provinceController.value.text,
        addressDistrict: districtController.value.text,
        address: address.value,
        birthday: _birthday.toUtc().toString(),
      );
      NetworkState state = await appRepository.updateInfo(
          id: this.entity.value.sId ?? AppPref.user.sId ?? "", entity: entity);
      if (state.isSuccess && state.data != null) {
        setLoading(false);
        AppPref.user = state.data as UserEntity;
        AppUtils.showToast('Cập nhật thành công!!!');
        Get.back();
      } else {
        setLoading(false);
        AppUtils.showToast('Cập nhật thất bại!!!');
        Get.back(result: true);
      }
    } else {
      AppUtils.showToast('Không có gì thay đổi!!!');
      Get.back(result: true);
    }
  }

  bool checkEditInfo() {
    if (name.value != AppPref.user.fullName ||
        gender.value != AppPref.user.gender ||
        address.value != AppPref.user.address ||
        provinceController.value.text != AppPref.user.addressProvince ||
        districtController.value.text != AppPref.user.addressDistrict ||
        avatar.value.toString() != File('').toString() ||
        (AppPref.user.birthday != null &&
            _birthday != DateTimeUtils.parse(AppPref.user.birthday!)) ||
        phoneController.value.text.toString() != AppPref.user.phone) {
      return true;
    }
    return false;
  }

  Future<String?> pickDateOfBirth(BuildContext context) async {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    ).then((DateTime? value) {
      if (value == null) return null;
      if (DateTimeUtils.getDate(value).millisecondsSinceEpoch >=
          DateTimeUtils.getDate(DateTime.now()).millisecondsSinceEpoch) {
        AppUtils.showToast("Thời gian không hợp lệ!!!");
        return DateFormat('dd-MM-yyyy').format(value);
      }
      _birthday = value;
      return DateFormat('dd-MM-yyyy').format(value);
    });
  }
}
