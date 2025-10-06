import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_maker/di/injection.dart';
import 'package:coffee_maker/firebase_options_development.dart' as dev;
import 'package:coffee_maker/firebase_options_production.dart' as production;
import 'package:coffee_maker/firebase_options_staging.dart' as staging;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

enum AppFlavor {
  development,
  staging,
  production,
}

final class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  static final _logger = Logger('AppBlocObserver');

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    _logger.info('AppBlocObserver.onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    final trace = Trace.from(stackTrace);
    _logger.severe(
      'AppBlocObserver.onError(${bloc.runtimeType}, $error, ${trace.terse})',
      error,
      trace.terse,
    );
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(
  FutureOr<Widget> Function() builder,
  AppFlavor flavor,
) async {
  return Chain.capture<void>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      Logger.root.level = kDebugMode ? Level.ALL : Level.INFO;
      Logger.root.onRecord.listen(
        (record) {
          if (kDebugMode) {
            print('${record.level.name}: ${record.time}: ${record.message}');
          }
        },
      );

      await Firebase.initializeApp(
        options: switch (flavor) {
          AppFlavor.production =>
            production.DefaultFirebaseOptions.currentPlatform,
          AppFlavor.staging => staging.DefaultFirebaseOptions.currentPlatform,
          AppFlavor.development => dev.DefaultFirebaseOptions.currentPlatform,
        },
      );

      FlutterError.onError = (details) async {
        final trace = Trace.from(details.stack ?? StackTrace.current);
        Logger.root.severe(
          details.exceptionAsString(),
          details.exception,
          trace.terse,
        );

        await FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      };

      Bloc.observer = const AppBlocObserver();

      await configureDependencies();

      runApp(await builder());
    },
    onError: (error, stackTrace) {
      final trace = Trace.from(stackTrace);
      Logger.root.severe(
        error.toString(),
        error,
        trace.terse,
      );
    },
    zoneValues: {#flutter.io.allow_http: false},
  );
}
