import 'package:device_info_plus/device_info_plus.dart';

class DeviceUtils {
  static Future<int> getAndroidSdkVersion() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt;
  }
}
