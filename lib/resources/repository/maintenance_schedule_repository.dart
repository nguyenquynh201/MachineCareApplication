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

  Future<NetworkState<List<MaintenanceScheduleEntity>>> getMaintenanceSchedule({
    required int offset,
    required int limit,
    String search = EndPoint.EMPTY_STRING,
    String? statusId,
    DateTime? from,
    DateTime? to,
  }) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      String url = "${endPoint.maintenanceSchedule}?limit=$limit&offset=$offset";
      if (from != null && to != null) {
        url += "&fromDate=${DateTimeUtils.dateToString(from)}";
        url += "&toDate=${DateTimeUtils.dateToString(to)}";
      }
      if (!StringUtils.isEmpty(search)) {
        url += "&search=${Uri.encodeQueryComponent(search)}";
      }
      if (!StringUtils.isEmpty(statusId)) {
        url += "&status=$statusId";
      }
      final Options options = Options(
        headers: {
          "Authorization": "Bearer ${AppPref.token.accessToken}",
          'content-Type': 'application/json'
        },
      );
      AppUtils.logMessage("nè nè${AppPref.token.accessToken}");
      Response response = await appClients.get(url, options: options);
      AppUtils.logMessage("response${response.data}");
      return NetworkState(
          status: EndPoint.success,
          response: MaintenanceScheduleEntity.listFromJson(response.data['data']),
          total: response.data['total']);
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }

  Future<NetworkState<MaintenanceScheduleEntity>> getMaintenanceScheduleById(
      {required String id}) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      String url = "${endPoint.maintenanceSchedule}/$id";
      final Options options = Options(
        headers: {
          "Authorization": "Bearer ${AppPref.token.accessToken}",
          'content-Type': 'application/json'
        },
      );
      AppUtils.logMessage("nè nè${AppPref.token.accessToken}");
      Response response = await appClients.get(url, options: options);
      AppUtils.logMessage("response${response.data}");
      return NetworkState(
        status: EndPoint.success,
        response: MaintenanceScheduleEntity.fromJson(response.data),
      );
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
  Future<NetworkState<MaintenanceScheduleEntity>> updateRepair(
      { required String id,required MaintenanceScheduleEntity entity}) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      AppUtils.logMessage("nè nè${AppPref.token.accessToken}");
      String api = "${endPoint.maintenanceSchedule}/$id";
      Response response = await appClients.put(api, data: entity.toJsonUpdate());
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
  Future<NetworkState<RatingEntity>> updateRating({required RatingEntity entity}) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      AppUtils.logMessage("nè nè${AppPref.token.accessToken}");
      String api = endPoint.rating;
      Response response = await appClients.post(api, data: entity.toJson());
      AppUtils.logMessage("response${response.data}");
      return NetworkState(status: EndPoint.success, response: RatingEntity.fromJson(response.data));
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }
  Future<NetworkState<List<HistoryRepairEntity>>> getHistory({required String id}) async {
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
      String api = "${endPoint.maintenanceScheduleHistory}/$id";
      Response response = await appClients.get(api, options: options);
      AppUtils.logMessage("response${response.data}");
      return NetworkState(
          status: EndPoint.success,
          response: HistoryRepairEntity.listFromJson(response.data['data']),
          total: response.data['total']);
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }
}
