import 'package:dio/dio.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/resources/path/path.dart';
import 'package:machine_care/resources/provider/app_client.dart';
import 'package:machine_care/services/service.dart';
import 'package:machine_care/utils/utils.dart';

import '../model/model.dart';

class MaintenanceScheduleRepository {
  final AppClients appClients;
  final AppPath endPoint;

  MaintenanceScheduleRepository(this.appClients, this.endPoint);

  Future<NetworkState<List<MaintenanceScheduleEntity>>> getMaintenanceSchedule() async {
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
      String api = endPoint.maintenanceSchedule;
      Response response = await appClients.get(api, options: options);
      AppUtils.logMessage("response${response.data}");
      return NetworkState(
          status: EndPoint.success,
          response: MaintenanceScheduleEntity.listFromJson(response.data['data']),
          total: response.data['total']);
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }

  Future<NetworkState<List<ErrorMachineEntity>>> getErrorMachine() async {
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
      String api = endPoint.error;
      Response response = await appClients.get(api, options: options);
      AppUtils.logMessage("response${response.data}");
      return NetworkState(
          status: EndPoint.success,
          response: ErrorMachineEntity.listFromJson(response.data['data']),
          total: response.data['total']);
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }

  Future<NetworkState<List<StatusEntity>>> getStatus() async {
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
      String api = endPoint.status;
      Response response = await appClients.get(api, options: options);
      AppUtils.logMessage("response${response.data}");
      return NetworkState(
          status: EndPoint.success,
          response: StatusEntity.listFromJson(response.data['data']),
          total: response.data['total']);
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }

  Future<NetworkState<MaintenanceScheduleEntity>> createRepair(
      {required MaintenanceScheduleEntity entity}) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      AppUtils.logMessage("nè nè${AppPref.token.accessToken}");
      String api = endPoint.maintenanceSchedule;
      Response response = await appClients.post(api, data: entity.toJson());
      AppUtils.logMessage("response${response.data}");
      return NetworkState(
          status: EndPoint.success, response: MaintenanceScheduleEntity.fromJson(response.data));
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }

  Future<NetworkState<List<ProvinceEntity>>> getProvince({
    String search = EndPoint.EMPTY_STRING,
  }) async {
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
      String api = "${endPoint.province}/provinces";
      Response response = await appClients.get(api, options: options);
      AppUtils.logMessage("response${response.data}");
      return NetworkState(
          status: EndPoint.success,
          response: List.from(response.data['data'])
              .map((e) => ProvinceEntity.fromJson(e))
              .where((element) {
            final nameLower = element.name!.toLowerCase();
            final searchLower = search.toLowerCase();
            return nameLower.contains(searchLower);
          }).toList(),
          total: response.data['total']);
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }

  Future<NetworkState<List<DistrictEntity>>> getDistrict({
    required String idProvince,
    String search = EndPoint.EMPTY_STRING,
  }) async {
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
      String api = "${endPoint.province}/$idProvince/districts";
      Response response = await appClients.get(api, options: options);
      AppUtils.logMessage("response${response.data}");
      return NetworkState(
          status: EndPoint.success,
          response: List.from(response.data['data'])
              .map((e) => DistrictEntity.fromJson(e))
              .where((element) {
            final nameLower = element.name!.toLowerCase();
            final searchLower = search.toLowerCase();
            return nameLower.contains(searchLower);
          }).toList(),
          total: response.data['total']);
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }

  Future<NetworkState<UserAddress>> createAddress({required UserAddress entity}) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      AppUtils.logMessage("nè nè${AppPref.token.accessToken}");
      String api = endPoint.address;
      Response response = await appClients.post(api, data: entity.toJson());
      AppUtils.logMessage("response${response.data}");
      return NetworkState(status: EndPoint.success, response: UserAddress.fromJson(response.data));
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }

  Future<NetworkState<List<UserAddress>>> getAddress() async {
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
      String api = endPoint.address;
      Response response = await appClients.get(api, options: options);
      AppUtils.logMessage("response${response.data}");
      return NetworkState(
          status: EndPoint.success,
          response: UserAddress.listFromJson(response.data['data']),
          total: response.data['total']);
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }
}
