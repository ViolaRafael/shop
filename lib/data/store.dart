import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Store {
  /// Saves all info of login in Strings usable through their keys
  static Future<bool> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  /// saves a list to phone's memory composed of login info
  static Future<bool> saveMap(String key, Map<String, dynamic> value) async {
    return saveString(key, jsonEncode(value));
  }

  /// gets saved keys from memory and turns them to string if there aren't any returns null
  static Future<String> getString(String key, [String defaultValue = '']) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? defaultValue;
  }
  /// makes a list out of the keys gotten from memory above
  static Future<Map<String, dynamic>> getMap(String key) async {
    try {
    return jsonDecode(await getString(key));
    } catch (_) {
      return {};
    }
  }
  /// removes saved keys from memory preventing it from not allowing user to log out
  static Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}