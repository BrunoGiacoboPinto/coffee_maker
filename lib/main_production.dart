import 'package:coffee_maker/app/app.dart';
import 'package:coffee_maker/bootstrap.dart';
import 'package:coffee_maker/firebase_options_production.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await bootstrap(() => const App());
}
