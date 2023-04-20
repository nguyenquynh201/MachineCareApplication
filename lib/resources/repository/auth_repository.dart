import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/model/model.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/resources/path/path.dart';
import 'package:machine_care/resources/provider/app_client.dart';
import 'package:machine_care/services/service.dart';
import 'package:machine_care/utils/utils.dart';

class AuthRepository {
  final AppClients appClients;
  final AppPath endPoint;
  AuthRepository(this.appClients, this.endPoint);
  Future<NetworkState<AuthEntity>> login(String phone, String password) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      Map<String, dynamic> param = {"username": phone, "password": password};
      String api = endPoint.login;
      Response response = await appClients.post(api, data: param);
      AppUtils.logMessage("response${response.data}");
      return NetworkState(status: EndPoint.success, response: AuthEntity.fromJson(response.data));
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }

  Future<NetworkState<UserEntity>> getMyProfile() async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      final Options options = Options(
        headers: {
          "Authorization": "Bearer ${AppPref.token.accessToken}",
          'content-Type': 'application/json'
        },
      );
      AppUtils.logMessage("nè nè${AppPref.token.accessToken}");
      String api = endPoint.userMe;
      Response response = await appClients.get(api, options: options);
      AppUtils.logMessage("response${response.data}");
      return NetworkState(status: EndPoint.success, response: UserEntity.fromJson(response.data));
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }

  Future<NetworkState<List<BannerEntity>>> getBanner() async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      final Options options = Options(
        headers: {
          "Authorization": "Bearer ${AppPref.token.accessToken}",
          'content-Type': 'application/json'
        },
      );
      AppUtils.logMessage("nè nè${AppPref.token.accessToken}");
      String api = endPoint.banner;
      Response response = await appClients.get(api, options: options);
      AppUtils.logMessage("response${response.data}");
      return NetworkState(
          status: EndPoint.success,
          response: BannerEntity.listFromJson(response.data['data']),
          total: response.data['total']);
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }

  Future<NetworkState<AuthEntity>> refreshToken({
    required String accessToken,
    required String refreshToken,
  }) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      Map<String, String> data = {"refreshToken": refreshToken, "accessToken": accessToken};
      AppUtils.logMessage("nè nè${AppPref.token.accessToken}");
      String api = endPoint.refreshToken;
      Response response = await appClients.post(api, data: data);
      AppUtils.logMessage("response${response.data}");
      return NetworkState(status: EndPoint.success, response: AuthEntity.fromJson(response.data));
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }
}
