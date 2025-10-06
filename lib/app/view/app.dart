import 'package:coffee_maker/app/router/app_router.dart';
import 'package:coffee_maker/l10n/l10n.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: _lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: _darkColorScheme),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: appRouter,
    );
  }
}

const _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF4A2C2A),
  onPrimary: Color(0xFFF8F4E3),
  secondary: Color(0xFF2C5E8A),
  onSecondary: Color(0xFFFFFFFF),
  tertiary: Color(0xFFB18733),
  onTertiary: Color(0xFF333733),
  error: Color(0xFFFF6868),
  onError: Color(0xFF333733),
  surface: Color(0xFFE5D5C1),
  onSurface: Color(0xFF333733),
);

const _darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFE5D5C1),
  onPrimary: Color(0xFF333733),
  secondary: Color(0xFFE5D5C1),
  onSecondary: Color(0xFF333733),
  tertiary: Color(0xFFB18733),
  onTertiary: Color(0xFF333733),
  error: Color(0xFFFF6868),
  onError: Color(0xFF333733),
  surface: Color(0xFF4A2C2A),
  onSurface: Color(0xFFF8F4E3),
);
