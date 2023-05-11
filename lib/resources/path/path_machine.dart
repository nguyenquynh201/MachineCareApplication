import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/path/path.dart';

class PathMachine extends AppPath{
  static String baseUrl = EndPoint.baseUrl;
  @override
  String get login => "$baseUrl/auth/login";

  @override
  String get userMe => "$baseUrl/users/me";

  @override
  // TODO: implement productMe
  String get productMe => "$baseUrl/users/product";

  @override
  // TODO: implement banner
  String get banner => "$baseUrl/banner";

  @override
  // TODO: implement refreshToken
  String get refreshToken =>  "$baseUrl/auth/refresh_token";

  @override
  // TODO: implement maintenanceSchedule
    String get maintenanceSchedule =>  "$baseUrl/maintenance-schedule";

  @override
  // TODO: implement error
  String get error =>  "$baseUrl/error-machine";

  @override
  // TODO: implement status
  String get status => "$baseUrl/maintenance-schedule-status";

  @override
  // TODO: implement province
  String get province => "$baseUrl/province";

  @override
  // TODO: implement addAddress
  String get address => "$baseUrl/users/address";

  @override
  // TODO: implement user
  String get user => "$baseUrl/users";

  @override
  // TODO: implement rating
  String get rating => "$baseUrl/maintenance-schedule-rate";

  @override
  // TODO: implement maintenanceScheduleHistory
  String get maintenanceScheduleHistory => "$baseUrl/maintenance-schedule-notification";

  @override
  // TODO: implement notification
  String get notification => "$baseUrl/Notifications";

}