import 'package:dio/dio.dart' as dio;
import '../../ui/ui.dart';
class NetworkState<T> {
  int? status;
  String? message;
  T? response;
  int? total;
  NetworkState({this.message, this.response, this.status , this.total});

  NetworkState.withError(error) {
    String? message;
    int? code;
    if (error != null) {
      dio.Response? response = error.response;
      if (response != null) {
        code = response.statusCode;
        message = error.message;
      } else {
        code = 500;
      }
      this.message = message ?? "";
      status = code;
      this.response = null;
      total = 0;
    } else {
      status = 500;
      message = "";
      response = null;
      total = 0;
    }
    return;
  }

  NetworkState.withDisconnect() {
    message = 'disconnect'.tr;
    status = -1;
    response = null;
    showDialogDisconnect();
  }

  Future<void> showDialogDisconnect() async {
    if (!Get.isDialogOpen!) {
      // Get.dialog(DialogConfirm(
      //   isConfirm: true,
      //   title: 'error_occurs'.tr,
      //   content: 'disconnect'.tr,
      //   titleConfirm: "close".tr,
      // ));
    }
  }

  NetworkState.withErrors(String this.message) {
    response = null;
  }

  T? get data => response;

  bool get isSuccess => status == 200 && response != null;

  bool get isError => status != 200 || response == null;
}
