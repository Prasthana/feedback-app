import 'package:oneononetalks/api_services/models/employee.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Check this bug in iOS when using fluttersecurestorage
// https://dev.to/isurujn/beware-of-fluttersecurestorage-on-ios-m6e

// If unable to build iOS project
// https://github.com/CocoaPods/CocoaPods/issues/10220#issuecomment-730963835

class StorageManager {
  final _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock));


  saveData(String key, String value) async {
    await _storage.write(
        key: key,
        value: value,
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: const IOSOptions(
            accessibility: KeychainAccessibility.first_unlock));
  }

  getData(String key) async {
    return await _storage.read(key: key) ?? 'No data found!';
  }

  removeData(String key) async {
    await _storage.delete(key: key);
  }
}
