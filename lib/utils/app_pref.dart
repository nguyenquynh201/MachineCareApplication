import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
class AppPref {
  AppPref._();

  static Box? _box;
  static String? appDirectory;
  static initListener() async {
    if (!kIsWeb) {
      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      appDirectory = appDocDirectory.path;
      Hive.init(appDirectory);
    }
    _box = await Hive.openBox('AppPref');
  }
  static set locale(String? locale) => _box?.put('locale', locale);

  static String? get locale =>
      _box?.get('locale', defaultValue: const Locale("vi", "VN").toString());

}