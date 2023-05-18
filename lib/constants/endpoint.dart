class EndPoint {
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const String keyAuthorization = "Authorization";
  static const int success = 200;
  static const int errorToken = 401;
  static const int errorValidate = 422;
  static const int errorServer = 500;
  static const int errorDisconnect = -1;
  static const String baseUrl = 'http://192.168.1.8:3000';
  static const int TWO = 2;
  static const int DAYS_OF_MONTH = 30;
  static const int TWO_MONTH = TWO * DAYS_OF_MONTH;
  static const int NO_ELEMENT = -1;
  static const String EMPTY_STRING = "";
  static const int LIMIT = 10;
  static const int MINIMUM_PHONE_LENGTH = 10;
  static const int MINIMUM_PASSWORD_LENGTH = 6;


}