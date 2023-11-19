import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class AppTheme {
  AppTheme._();

  /// This function will generate ThemeData in [MaterialApp] in [App]
  static ThemeData getThemeData({required bool isLightTheme}) {
    return ThemeData(
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: AppFonts.poppins,
      colorSchemeSeed:
          isLightTheme ? AppColors.primaryLight : AppColors.primaryDark,
    );
  }
}
