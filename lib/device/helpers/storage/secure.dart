import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(encryptedSharedPreferences: true);

  static IOSOptions _getIOSOptions() => const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  static late FlutterSecureStorage _storage;

  static init() {
    _storage = FlutterSecureStorage(aOptions: _getAndroidOptions(), iOptions: _getIOSOptions());
  }

  static Future<Map<String, String>> get allValues async => await _storage.readAll();

  static Future<String?> read(String key, {String? feedBack}) async => (await _storage.read(key: key)) ?? feedBack;

  static Future<void> set(String key, {required String value}) async => await _storage.write(key: key, value: value);

  static Future<void> delete(String key, {bool all = false}) async => all ? await _storage.deleteAll() : await _storage.delete(key: key);
}
