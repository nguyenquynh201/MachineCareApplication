import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class DeviceService {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static Future<String?> getDeviceId() async {
    String? deviceId;

    try {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
        deviceId = androidDeviceInfo.id;
        print("androidDeviceInfo.id ${androidDeviceInfo.id}");
        print("androidDeviceInfo.device ${androidDeviceInfo.device}");
        print("androidDeviceInfo.model ${androidDeviceInfo.model}");
        print("androidDeviceInfo.type ${androidDeviceInfo.type}");
        print("androidDeviceInfo.type ${androidDeviceInfo.toMap().toString()}");
      } else if (Platform.isIOS) {
        final IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
        deviceId = iosDeviceInfo.identifierForVendor;
      }
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      int? modelNumber;
      String platform = "ANDROID";
      if (iosInfo.utsname.machine?.contains("iPhone") == true) {
        String iphone = iosInfo.utsname.machine!
            .substring(0, iosInfo.utsname.machine!.indexOf(","))
            .replaceAll("iPhone", "");
        modelNumber = int.tryParse(iphone);
      }
      String tempDir = (await getTemporaryDirectory()).path;
      if (Platform.isAndroid) {
        platform = "ANDROID";
      } else if (Platform.isIOS) {
        platform = "IOS";
      }
      print("nè nè $modelNumber");
    } catch (e) {
      print('Error getting device id: $e');
    }

    return deviceId;
  }
}
