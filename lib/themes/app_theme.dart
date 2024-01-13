import 'package:flutter/material.dart';

import '../constants/color_constant.dart';
import 'widget_themes/text_themes.dart';

class AppThemes {
  static appLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(background: KColors.rose900),
      textTheme: KTextThemes.lightTextThemes(),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 4,
        backgroundColor: KColors.rose900,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 32,
        ),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 28),
        shadowColor: Colors.black,
      ),
    );
  }

  static appDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      textTheme: KTextThemes.darkTextTheme(),
      iconTheme: const IconThemeData(color: Colors.white),
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: KColors.darkBgColor,
      colorScheme: const ColorScheme.dark(background: KColors.rose900),
      appBarTheme: const AppBarTheme(
        elevation: 4,
        backgroundColor: KColors.rose900,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 32,
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 28,
        ),
        shadowColor: Colors.black,
      ),
    );
  }
}
