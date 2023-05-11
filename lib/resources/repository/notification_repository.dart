import 'package:dio/dio.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/model/model.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/resources/path/path.dart';
import 'package:machine_care/resources/provider/app_client.dart';
import 'package:machine_care/services/service.dart';
import 'package:machine_care/utils/utils.dart';

class NotificationRepository {
  final AppClients appClients;
  final AppPath endPoint;

  NotificationRepository(this.appClients, this.endPoint);

  Future<NetworkState<List<NotificationEntity>>> getNotification({
    required int offset,
    required int limit,
  }) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      String url = "${endPoint.notification}?limit=$limit&offset=$offset";
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
          response: NotificationEntity.listFromJson(response.data['data']),
          total: response.data['total']);
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }

  Future<NetworkState<NotificationEntity>> getNotificationById({required String id}) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      String url = "${endPoint.notification}/$id";
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
        response: NotificationEntity.fromJson(response.data),
      );
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }
  Future<NetworkState<dynamic>> readNotification({required String id}) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      AppUtils.logMessage("nè nè${AppPref.token.accessToken}");
      Map<String , dynamic> entity = {
        "isRead" : true
      };
      String api = "${endPoint.notification}/$id";
      Response response = await appClients.put(api, data: entity);
      AppUtils.logMessage("response${response.data}");
      return NetworkState(
          status: EndPoint.success, response: MaintenanceScheduleEntity.fromJson(response.data));
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }
  Future<NetworkState<dynamic>> updateRequestReceived({required String id , required String idAdmin , required Map<String , dynamic> data}) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      AppUtils.logMessage("nè nè${AppPref.token.accessToken}");
      AppUtils.logMessage("data$data");
      String api = "${endPoint.maintenanceSchedule}/$id/updateRequestApply/$idAdmin";
      Response response = await appClients.post(api, data: data);
      AppUtils.logMessage("response${response.data}");
      return NetworkState(
          status: EndPoint.success, response: response.data);
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }
}
