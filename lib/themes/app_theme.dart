import 'package:flutter/material.dart';
import 'package:table_booking/themes/widget_themes/text_themes.dart';

class AppThemes {
  static appLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: Colors.white,
      textTheme: KTextThemes.lightTextThemes(),
    );
  }

  static appDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      textTheme: KTextThemes.darkTextTheme(),
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: const Color(0xFF282C3B),
    );
  }
}
