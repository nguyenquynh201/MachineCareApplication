import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/path/path.dart';

class PathMachine extends AppPath{
  static String baseUrl = EndPoint.baseUrl;
  @override
  // TODO: implement login
  String get login => "$baseUrl/auth/login";

}