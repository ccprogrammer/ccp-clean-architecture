import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Prefs._();

  // STORING KEYS
  static const _isFirstTimerKey = 'isFirstTimer';

  // FIREBASE CLOUD MESSANGING TOKEN
  static const String _userTokenKey = 'userToken';
  static const String _fcmTokenKey = 'fcmToken';

  // APP THEME KEY
  static const String _isLightThemeKey = 'isLightTheme';

  static late SharedPreferences _prefs;

  /// Initialize shared preferences instance
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // * USER TOKEN STUFF
  /// save generated user token
  static Future<void> setUserToken(String token) =>
      _prefs.setString(_userTokenKey, token);

  /// get user token
  static String? getUserToken() => _prefs.getString(_userTokenKey);

  // * FCM STUFF
  /// save generated fcm token
  static Future<void> setFcmToken(String token) =>
      _prefs.setString(_fcmTokenKey, token);

  /// get authorization token
  static String? getFcmToken() => _prefs.getString(_fcmTokenKey);

  // * THEME
  /// set theme current type as light theme
  static Future<void> setThemeIsLight(bool lightTheme) =>
      _prefs.setBool(_isLightThemeKey, lightTheme);

  /// get if the current theme type is light
  static bool getThemeIsLight() =>
      _prefs.getBool(_isLightThemeKey) ??
      true; // todo set the default theme (true for light, false for dark)

  // * FIRST INSTALL RUNNING APP
  /// set user to not first timer
  static Future<bool> setIsFirstTimer() {
    return _prefs.setBool(_isFirstTimerKey, false);
  }

  /// check if user is first time open the app
  static bool getIsFirstTimer() {
    return _prefs.getBool(_isFirstTimerKey) ?? true;
  }

  // * REMOVE ALL CACHE STORAGE
  ///  clear all data from shared pref
  static Future<void> clear() async => await _prefs.clear();
}
