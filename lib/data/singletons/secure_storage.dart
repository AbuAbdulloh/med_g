import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepository {
  static SecureStorageRepository? _storageUtil;
  static FlutterSecureStorage? _preferences;

  static Future<SecureStorageRepository> getInstance() async {
    if (_storageUtil == null) {
      final secureStorage = SecureStorageRepository._();
      _storageUtil = secureStorage;
    }
    return _storageUtil!;
  }

  SecureStorageRepository._();

  static Future<void>? putString(String key, String value) {
    if (_preferences == null) return null;
    return _preferences!.write(key: key, value: value);
  }

  static String getString(String key, {String defValue = ''}) {
    if (_preferences == null) return defValue;
    return _preferences!.read(key: key).toString();
  }

  static Future<void>? deleteString(String key) {
    if (_preferences == null) return null;
    _preferences!.delete(key: key);
  }
}
