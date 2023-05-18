import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
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
      Response response = await AppClients().get(api, options: options);
      AppUtils.logMessage("response${response.data}");
      return NetworkState(status: EndPoint.success, response: UserEntity.fromJson(response.data));
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }

  Future<NetworkState<dynamic>> resetPassword(
      {required String id, required String currentPassword, required String newPassword}) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      AppUtils.logMessage("nè nè${AppPref.token.accessToken}");
      String api = "${endPoint.user}/$id/password";
      Map<String, dynamic> param = {"currentPassword": currentPassword, "newPassword": newPassword};
      Response response = await appClients.post(api, data: param);
      AppUtils.logMessage("response${response.data}");
      return NetworkState(status: EndPoint.success, response: response.data);
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

  Future<NetworkState<dynamic>> updateToken({
    required String token,
  }) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      Map<String, String> data = {"deviceToken": token};
      AppUtils.logMessage("nè nè${AppPref.token.accessToken}");
      String api = "${endPoint.user}/deviceToken";
      Response response = await appClients.post(api, data: data);
      AppUtils.logMessage("response${response.data}");
      return NetworkState(status: EndPoint.success, response: response.data);
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }

  Future<NetworkState<dynamic>> uploadImage({required String idUser, required File file}) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      FormData formData = FormData.fromMap({
        "file": [MultipartFile.fromFileSync(file.path)]
      });
      AppUtils.logMessage("nè nè${AppPref.token.accessToken}");
      String api = "${endPoint.user}/$idUser/avatars";
      Response response = await appClients.post(
        api,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer ${AppPref.token.accessToken}'
          },
        ),
      );
      AppUtils.logMessage("response${response.data}");
      return NetworkState(status: EndPoint.success, response: response.data);
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }
  Future<NetworkState<UserEntity>> updateInfo({
    required String id,
    required UserEntity entity
  }) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      AppUtils.logMessage("nè nè${AppPref.token.accessToken}");
      String api = "${endPoint.user}/$id";
      Response response = await appClients.put(api, data: entity.toJonUpdate());
      AppUtils.logMessage("response${response.data}");
      return NetworkState(status: EndPoint.success, response: UserEntity.fromJson(response.data));
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }
}
