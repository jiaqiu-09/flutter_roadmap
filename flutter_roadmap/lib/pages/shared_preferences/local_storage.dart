import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences? _prefs;
  LocalStorage._internal();

  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // 保存字符串
  Future<bool?> saveString(String key, String value) async {
    return await _prefs?.setString(key, value);
  }

  // 读取字符串
  String? getString(String key) {
    return _prefs?.getString(key);
  }

  // 保存整数
  Future<bool?> saveInt(String key, int value) async {
    return await _prefs?.setInt(key, value);
  }

  // 读取整数
  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  // 保存布尔值
  Future<bool?> saveBool(String key, bool value) async {
    return await _prefs?.setBool(key, value);
  }

  // 读取布尔值
  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  // 保存双精度浮点数
  Future<bool?> saveDouble(String key, double value) async {
    return await _prefs?.setDouble(key, value);
  }

  // 读取双精度浮点数
  double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  // 保存字符串列表
  Future<bool?> saveStringList(String key, List<String> value) async {
    return await _prefs?.setStringList(key, value);
  }

  // 读取字符串列表
  List<String>? getStringList(String key) {
    return _prefs?.getStringList(key);
  }

  // 移除某个键
  Future<bool?> remove(String key) async {
    return await _prefs?.remove(key);
  }

  // 清除所有数据
  Future<bool?> clear() async {
    return await _prefs?.clear();
  }
}
