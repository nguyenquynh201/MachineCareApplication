import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_care/resources/model/model.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/resources/repository/app_repository.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:machine_care/utils/app_pref.dart';

class BaseController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    setLoading(false);
  }
  static GlobalKey navigationKey = GlobalKey();

  @override
  void onClose() {
    super.onClose();
    setLoading(false);
  }

  var loading = false.obs;

  setLoading(bool status) => loading.value = status;

  Future<UserEntity?> getProfile() async {
    NetworkState state = await appRepository.getMyProfile();
    if(state.isSuccess && state.data != null) {
      AppPref.user = state.data;
    }
    return state.data;
  }

  AppRepository appRepository = getIt.get();
}
