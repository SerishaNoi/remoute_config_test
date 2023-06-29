import 'package:hive/hive.dart';

class LocalStorage {
  Future storeLink(String key, String link) async {
    final box = await Hive.openBox('linkBox');
    if (box == null) return;

    await box.put(key, link);
  }

  dynamic getLink(String key) async {
    final box = await Hive.openBox('linkBox');
    if (box == null) return;

    return box.get(key);
  }
}
