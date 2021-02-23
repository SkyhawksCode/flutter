import 'package:shared_preferences/shared_preferences.dart';

///this class is used to handle shared preference
class PreferenceUtils {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  ///Get string preference
  static String getString(String key, [String defValue]) {
    return _prefsInstance.getString(key) ?? defValue ?? "";
  }

  ///Get boolean preference
  static bool getBool(String key, [bool defValue]) {
    return _prefsInstance.getBool(key) ?? defValue ?? false;
  }

  ///set string preference
  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs?.setString(key, value) ?? Future.value(false);
  }

  ///set int preference
  static Future<bool> setInt(String key, int value) async {
    var prefs = await _instance;
    return prefs?.setInt(key, value) ?? Future.value(false);
  }

  ///Get bool preference
  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs?.setBool(key, value) ?? Future.value(false);
  }
}
