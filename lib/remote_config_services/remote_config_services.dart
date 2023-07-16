import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RomoteConfigServices {
  final FirebaseRemoteConfig firebaseRemoteConfig = FirebaseRemoteConfig.instance;

  String getString(String key) => firebaseRemoteConfig.getString(key);

  Map<String, RemoteConfigValue> getAll() => firebaseRemoteConfig.getAll();

  Future<void> init() async {
    await _setConfigSettings();
    await _fetchAndActivate();
  }

  Future<void> _setConfigSettings() async {
    await firebaseRemoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 1),
        minimumFetchInterval: const Duration(minutes: 1),
      ),
    );
  }

  Future<void> _fetchAndActivate() async {
    final result = await Connectivity().checkConnectivity();
    
    if (result != ConnectivityResult.none) {
      bool updated = await firebaseRemoteConfig.fetchAndActivate();

      if (updated == true) {
        print('configuration has been updated');
      } else {
        print('configuration has not been updated');
      }
    }
    print('configuration has not been updated');
  }
}
