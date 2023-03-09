import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  static Future<void> initialize() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
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