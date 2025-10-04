import 'package:coffee_maker/app/app.dart';
import 'package:coffee_maker/bootstrap.dart';
import 'package:coffee_maker/di/injection.dart';
import 'package:coffee_maker/network/cubit/connectivity_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  await bootstrap(
    () => BlocProvider(
      create: (_) => getIt<ConnectivityCubit>()..initialize(),
      child: const App(),
    ),
  );
}
