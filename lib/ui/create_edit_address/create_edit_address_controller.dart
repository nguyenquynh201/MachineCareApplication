import 'package:flutter/cupertino.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/utils/utils.dart';

import '../ui.dart';

class CreateEditAddressController extends BaseController {
  Rx<bool> isFixed = false.obs;
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
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      UserAddress entity = Get.arguments as UserAddress;
      nameController.text = entity.nameAddress ?? EndPoint.EMPTY_STRING;
      phoneController.text = entity.phone ?? EndPoint.EMPTY_STRING;
      provinceController.value.text = entity.addressProvince ?? EndPoint.EMPTY_STRING;
      districtController.value.text = entity.addressDistrict ?? EndPoint.EMPTY_STRING;
      addressController.text = entity.addressUser ?? EndPoint.EMPTY_STRING;
      gender.value = entity.gender ?? Gender.female;
      isFixed.value = entity.fixed ?? false;
    }
  }

  void onChangeGender(Gender gender) {
    _gender.value = gender;
  }

  void updateFixed() {
    isFixed.value = !isFixed.value;
  }

  void onChangedName(String value) {
    name.value = value;
    AppUtils.logMessage(value);
  }

  void onChangedPhone(String value) {
    validatePhone.value = ValidatePhoneState.none;
    if (value.length > 10 || value.length < 10) {
      validatePhone.value = ValidatePhoneState.invalid;
    } else {
      validatePhone.value = ValidatePhoneState.none;
    }
    phone.value = value;
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

  Rx<bool> get enable {
    print(!StringUtils.isEmpty(name.value) &&
        !StringUtils.isEmpty(phone.value) &&
        !StringUtils.isEmpty(address.value) &&
        !StringUtils.isEmpty(provinceController.value.text) &&
        !StringUtils.isEmpty(districtController.value.text) &&
        validatePhone.value == ValidatePhoneState.none);
    return (!StringUtils.isEmpty(name.value) &&
            !StringUtils.isEmpty(phone.value) &&
            !StringUtils.isEmpty(address.value) &&
            !StringUtils.isEmpty(provinceController.value.text) &&
            !StringUtils.isEmpty(districtController.value.text) &&
            validatePhone.value == ValidatePhoneState.none)
        .obs;
  }

  void createAddress() async {
    try {
      setLoading(true);
      UserAddress _entity = UserAddress(
        userId: AppPref.user.sId,
        addressDistrict: districtController.value.text,
        addressProvince: provinceController.value.text,
        addressUser: address.value,
        gender: _gender.value,
        fixed: isFixed.value,
        nameAddress: name.value,
        phone: phone.value
      );
      NetworkState state = await appRepository.addAddress(entity: _entity);
      if(state.isSuccess && state.data != null) {
        setLoading(false);
        AppUtils.showToast("Tạo địa chỉ thành công");
        Get.back(result: true);
      }else {
        setLoading(false);
        AppUtils.showToast("Lỗi gì đó");
      }
    }catch(e) {
      setLoading(false);
      AppUtils.showToast(e.toString());
    }


  }
}
