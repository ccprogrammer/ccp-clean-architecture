import 'package:ccp_clean_architecture/core/common/models/user_model.dart';
import 'package:ccp_clean_architecture/core/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    initTheme();
  }
  
  bool _isLightModeOn = true;

  UserModel? _user;

  UserModel? get user => _user;

  ThemeMode get isLightModeOn =>
      _isLightModeOn ? ThemeMode.light : ThemeMode.dark;

  /// get last cached theme mode boolean from device
  void initTheme() {
    final isLightTheme = AppTheme.getThemeIsLight;

    if (!isLightTheme) {
      _isLightModeOn = false;
    }
  }

  void changeTheme(BuildContext context) {
    _isLightModeOn = !_isLightModeOn;
    notifyListeners();
  }

  void initUser(UserModel? user) {
    if (_user != user) _user = user;
  }

  void setUser(UserModel? user) {
    if (_user != user) {
      _user = user;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
