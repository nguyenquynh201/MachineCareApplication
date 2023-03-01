import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:machine_care/utils/app_utils.dart';

class AppLogger {
  static final RxBool _isLog = false.obs;
  static final RxString _filterType = "*:V".obs;

  static bool get isLog => _isLog.value;

  static void setIsLog(bool isNative) => _isLog.value = isNative;

  static String get filterType => _filterType.value;

  static void setFilterType(String filterType) => _filterType.value = filterType;

  static Logger? logger;

  static getLogger() {
    if (AppLogger.filterType.contains("V")) {
      Logger.root.level = Level.ALL;
    }
    if (AppLogger.filterType.contains("D")) {
      Logger.root.level = Level.CONFIG;
    }
    if (AppLogger.filterType.contains("I")) {
      Logger.root.level = Level.INFO;
    }
    if (AppLogger.filterType.contains("W")) {
      Logger.root.level = Level.WARNING;
    }
    if (AppLogger.filterType.contains("E")) {
      Logger.root.level = Level.SHOUT;
    }
    if (logger == null) {
      Logger.root.onRecord.listen((record) {
        AppUtils.logMessage('${record.level.name}: ${record.time}: ${record.message}');

        printMessage(record);
      });
    }
    logger ??= Logger("Yokara");
    return logger;
  }
  static void printMessage(LogRecord logRecord) {
    // if (AppLogger.isLog) {
    //   DateTime now = DateTime.now();
    //   var logcatLine = LogcatLine(
    //       tag: logRecord.level.name,
    //       level: AppLogger.filterType,
    //       msg: logRecord.message,
    //       pid: getIt.get<DeviceInfo>().packageName,
    //       tid: "",
    //       time: now.millisecondsSinceEpoch);
    //   setLogCat(logcatLine);
    // }
  }

}
class LogcatLine {
  String? tag;
  String? level;
  String? msg;
  String? pid;
  dynamic tid;
  dynamic time;

  LogcatLine({this.tag, this.level, this.msg, this.pid, this.tid, this.time});

  LogcatLine.fromJson(dynamic json) {
    tag = json['tag'];
    level = json['level'];
    msg = json['msg'];
    time = json['time'];
    pid = json['pid'];
    tid = json['tid'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tag'] = tag;
    map['level'] = level;
    map['msg'] = msg;
    map['time'] = time;
    map['pid'] = pid;
    map['tid'] = tid;
    return map;
  }
}