import 'package:flutter/material.dart';
import 'package:table_booking/provider/is_dark_theme.dart';
import 'package:table_booking/themes/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router/app_routes.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IsDarkTheme = ref.watch(isDarkThemeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: IsDarkTheme ? AppThemes.appDarkTheme() : AppThemes.appLightTheme(),
      // darkTheme: AppThemes.appDarkTheme(),
      routes: AppRoutes.getAppRoutes(),
      initialRoute: AppRoutes.navigationRoute,
    );
  }
}
