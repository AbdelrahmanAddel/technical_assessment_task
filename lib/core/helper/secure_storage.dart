import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final class SecureStorage {
  const SecureStorage({required this.storage});

  final FlutterSecureStorage storage;

  Future<void> write({required String key, required String value}) =>
      storage.write(key: key, value: value);

  Future<String?> read({required String key}) => storage.read(key: key);

  Future<void> delete({required String key}) => storage.delete(key: key);

  Future<void> deleteAll() => storage.deleteAll();
}
