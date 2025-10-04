import 'package:coffee_maker/counter/counter.dart';
import 'package:coffee_maker/l10n/l10n.dart';
import 'package:coffee_maker/network/view/connectivity_banner.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) => ConnectivityBanner(child: child!),
      home: const CounterPage(),
    );
  }
}
