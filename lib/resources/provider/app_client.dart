import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/di/server_locator.dart';
import 'package:machine_care/resources/repository/auth_repository.dart';
import 'package:machine_care/utils/utils.dart';

class AppClients extends DioForNative {
  static const String methodGet = "GET";
  static const String methodPost = "POST";
  static const String methodPut = "PUT";
  static const String methodDelete = "DELETE";

  static AppClients? _instance;

  factory AppClients({String baseUrl = EndPoint.baseUrl, BaseOptions? options}) {
    _instance ??= AppClients._(baseUrl: baseUrl, options: options);
    if (options != null) _instance!.options = options;
    _instance!.options.baseUrl = baseUrl;
    return _instance!;
  }

  final Dio dio = Dio();

  AppClients._({String baseUrl = EndPoint.baseUrl, BaseOptions? options}) : super(options) {
    interceptors.add(InterceptorsWrapper(
      onRequest: _requestInterceptor,
      onResponse: _responseInterceptor,
      onError: _errorInterceptor,
    ));
    this.options.baseUrl = baseUrl;
    this.options.baseUrl = baseUrl;
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
    );
    options.headers = {"Authorization": "Bearer ${AppPref.token.accessToken!}"};
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  _requestInterceptor(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addEntries([MapEntry('Authorization', 'Bearer ${AppPref.token.accessToken}')]);
    AppLogger.getLogger().shout("headers ${options.headers}");
    switch (options.method) {
      case AppClients.methodGet:
        AppLogger.getLogger()
            .shout("${options.method}: ${options.uri}\nParams: ${options.queryParameters}");
        break;
      case AppClients.methodPost:

        if (options.data is Map) {
          AppLogger.getLogger().shout("${options.method}: ${options.uri}\nParams: ${options.data}");
          options.contentType = 'application/json';
        } else if (options.data is FormData) {
          AppLogger.getLogger()
              .shout("${options.method}: ${options.uri}\nParams: ${options.data.fields}");
        }
        break;
      default:
        break;
    }
    options.connectTimeout = EndPoint.connectionTimeout;
    options.receiveTimeout = EndPoint.receiveTimeout;
    handler.next(options);
  }

  /// anh muốn log cái gì á
  /// data
  _responseInterceptor(Response response, ResponseInterceptorHandler handler) {
    AppLogger.getLogger().shout(
        "Url ${response.requestOptions.uri}: ${response.statusCode}\nData: ${response.data}");
    handler.next(response);
  }

  _errorInterceptor(DioError dioError, ErrorInterceptorHandler handler) {
    AppLogger.getLogger()
        .shout("${dioError.type} - Error ${dioError.message}\nData: ${dioError.response?.data}");
    handler.next(dioError);
  }
}
