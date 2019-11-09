import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  Future<String> getString(String key);
  Future<void> setString(String key, String value);
}

class LocalStorageImpl implements LocalStorage {
  final SharedPreferences sharedPreferences;

  LocalStorageImpl({this.sharedPreferences});

  @override
  Future<String> getString(String key) {
    // TODO: implement getString
    return null;
  }

  @override
  Future<void> setString(String key, String value) {
    // TODO: implement setString
    return null;
  }
}
