import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/model/model.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/resources/path/path.dart';
import 'package:machine_care/resources/provider/app_client.dart';
import 'package:machine_care/services/service.dart';
import 'package:machine_care/utils/utils.dart';

class ProductRepository {
  final AppClients appClients;
  final AppPath endPoint;
  ProductRepository(this.appClients, this.endPoint);

  Future<NetworkState<dynamic>> getProduct() async {
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
      String api = endPoint.productMe;
      Response response = await AppClients().get(api, options: options);
      AppUtils.logMessage("response${response.data}");
      return NetworkState(
          status: EndPoint.success,
          response:
              List.from(response.data['data']).map((e) => ProductUserEntity.fromJson(e)).toList(),
          total: response.data['total']);
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }
}
