import 'package:device_info_plus/device_info_plus.dart';

Future<bool> checkDevice() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  var androidInfo = await deviceInfoPlugin.androidInfo;

  if (androidInfo.brand == 'google' || androidInfo.isPhysicalDevice == false) {
    return true;
  }

  return false;
}
