import 'dart:convert';

import 'package:machine_care/utils/utils.dart';


class GALogger {

  // eventName
  static String screenView = 'screen_view';

  // paramName
  static String screenName = 'screen_name';
  static String description = 'description';

  static logEvent(String eventName, Map<String, Object>? parameters) {
    AppLogger.getLogger().shout("GALogger: $eventName - ${jsonEncode(parameters)}");
    // FirebaseAnalytics.instance.logEvent(name: eventName, parameters: parameters);
  }
}
