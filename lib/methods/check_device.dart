import 'package:device_info_plus/device_info_plus.dart';

Future<bool> checkDevice() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  var androidInfo = await deviceInfoPlugin.androidInfo;

  // add check to empty local link and emulator
  if (androidInfo.brand == 'google' || !androidInfo.isPhysicalDevice) {
    return true;
  }

  return false;
}
