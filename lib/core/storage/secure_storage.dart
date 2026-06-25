import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final class SecureStorage {
  SecureStorage._();

  static final SecureStorage instance = SecureStorage._();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> write({required String key, required String value}) =>
      _storage.write(key: key, value: value);

  Future<String?> read({required String key}) => _storage.read(key: key);

  Future<void> delete({required String key}) => _storage.delete(key: key);

  Future<void> deleteAll() => _storage.deleteAll();
}
