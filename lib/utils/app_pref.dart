import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:machine_care/resources/model/model.dart';
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

  static set user(UserEntity? _user) {
    if (_user != null) {
      _box!.put('user', jsonEncode(_user.toJson()));
    } else {
      _box!.delete('user');
    }
  }

  static UserEntity get user {
    final _ = _box?.get('user');
    if (_ != null) return UserEntity.fromJson(jsonDecode(_));
    return UserEntity();
  }

  static AuthEntity get token {
    final _ = _box?.get('authToken');
    if (_ != null) return AuthEntity.fromJson(jsonDecode(_));
    return AuthEntity();
  }

  static set token(AuthEntity? authToken) {
    if (authToken != null) {
      _box!.put('authToken', jsonEncode(authToken.toJson()));
    } else {
      _box!.delete('authToken');
    }
  }

  static set banner(List<FileEntity> _banner) {
    if (_banner.isNotEmpty) {
      _box?.put('banner',_banner.map((e) => e.toJson()).toList());
    } else {
      _box!.delete('banner');
    }
  }

  static List<FileEntity> get banner {
    final _ = _box?.get('banner');
    if (_ == null) return [];
    return List.from(_).map((e) => FileEntity.fromJsonHive(e)).toList();
  }
  static set userAddress(UserAddress? _userAddress) {
    if (_userAddress != null) {
      _box!.put('userAddress', jsonEncode(_userAddress.toJson()));
    } else {
      _box!.delete('userAddress');
    }
  }

  static UserAddress get userAddress {
    final _ = _box?.get('userAddress');
    if (_ != null) return UserAddress.fromJson(jsonDecode(_));
    return UserAddress();
  }
}
