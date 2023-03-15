import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  static Future<void> initialize() async {
    Hive.initFlutter();
  }

  Future<String?> get(String key) async {
    final box = await Hive.openBox('pokemon');
    return await box.get(key);
  }

  Future<void> save(String key, String value) async {
    final box = await Hive.openBox('pokemon');
    await box.put(key, value);
  }
}
