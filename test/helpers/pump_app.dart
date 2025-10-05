import 'package:coffee_maker/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'injection.dart';

extension PumpApp on WidgetTester {
  static bool _databaseFactoryInitialized = false;

  Future<void> pumpApp(Widget widget) async {
    await configureTestDependencies();
    return pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: widget,
      ),
    );
  }

  /// Pumps a widget with proper theme configuration for golden tests.
  Future<void> pumpAppWithTheme(
    Widget widget, {
    ThemeData? theme,
    ThemeData? darkTheme,
  }) async {
    await configureTestDependencies();
    return pumpWidget(
      MaterialApp(
        theme: theme ?? ThemeData(useMaterial3: true),
        darkTheme: darkTheme ?? ThemeData(useMaterial3: true),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: widget,
      ),
    );
  }

  /// Pumps a widget with GoRouter for testing navigation.
  Future<void> pumpAppWithRouter(Widget widget) async {
    await configureTestDependencies();
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => widget,
        ),
        GoRoute(
          path: '/details/:id',
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Details Page')),
          ),
        ),
      ],
    );

    return pumpWidget(
      MaterialApp.router(
        routerConfig: router,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }

  /// Sets up path_provider mocking for tests that use CachedNetworkImage.
  void setupPathProviderMocks() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (MethodCall methodCall) async {
            if (methodCall.method == 'getTemporaryDirectory') {
              return '/tmp';
            }
            if (methodCall.method == 'getApplicationSupportDirectory') {
              return '/tmp';
            }
            return null;
          },
        );
  }

  /// Sets up SQLite FFI for tests that use CachedNetworkImage.
  void setupDatabaseFactory() {
    if (!_databaseFactoryInitialized) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
      _databaseFactoryInitialized = true;
    }
  }
}
