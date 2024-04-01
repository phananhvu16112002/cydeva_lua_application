import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> writeSecureData(String key, String value) async {
    print('Write local successfully');
    print('key:$key');
    print('value:$value');

    await storage.write(key: key, value: value);
  }

  Future<String> readSecureData(String key) async {
    String value = await storage.read(key: key) ?? 'No Data Found';
    return value;
  }

  Future<void> deleteSecureData(String key) async {
    print('Delete successfully');
    await storage.delete(key: key);
  }
}
