class EndPoint {
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const String keyAuthorization = "Authorization";
  static const int success = 200;
  static const int errorToken = 401;
  static const int errorValidate = 422;
  static const int errorServer = 500;
  static const int errorDisconnect = -1;
}