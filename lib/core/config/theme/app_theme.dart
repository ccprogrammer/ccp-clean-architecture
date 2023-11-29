import 'package:ccp_clean_architecture/core/common/providers/app_provider.dart';
import 'package:ccp_clean_architecture/core/data/local/shared_preferences/my_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class AppTheme {
  AppTheme._();

  /// pass context to lookup the provider for theme change
  static void changeTheme(BuildContext context) {
    context.read<AppProvider>().changeTheme(context);

    // check if the current theme is light (default is light)
    bool isLightTheme = Prefs.getThemeIsLight();

    // store the new theme mode on get storage
    Prefs.setThemeIsLight(!isLightTheme);
  }

  static bool get getThemeIsLight => Prefs.getThemeIsLight();

  static get lightTheme => _getThemeData(isLightMode: true);

  static get darkTheme => _getThemeData(isLightMode: false);

  /// This function will generate ThemeData in [MaterialApp] in [App]
  static ThemeData _getThemeData({required bool isLightMode}) {
    return ThemeData(
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: AppFonts.poppins,
      colorSchemeSeed:
          isLightMode ? AppColors.primaryLight : AppColors.primaryDark,
      inputDecorationTheme: InputDecorationTheme(
        alignLabelWithHint: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryLight,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.red,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.red,
          ),
        ),
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(
          color: AppColors.black,
        ),
        bodyMedium: TextStyle(
          color: AppColors.black,
        ),
        bodyLarge: TextStyle(
          color: AppColors.black,
        ),
      ),
    );
  }
}
