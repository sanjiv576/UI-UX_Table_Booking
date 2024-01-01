import 'package:flutter/material.dart';
import 'package:table_booking/themes/app_theme.dart';

import 'router/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.appDarkTheme(),
      darkTheme: AppThemes.appDarkTheme(),
      routes: AppRoutes.getAppRoutes(),
      initialRoute: AppRoutes.navigationRoute,
    );
  }
}
