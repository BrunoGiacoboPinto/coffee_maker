import 'package:coffee_maker/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:network/network.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  getIt.init();

  final httpClientProvider = HttpClientProvider();
  getIt
    ..registerLazySingleton<HttpClientProvider>(() => httpClientProvider)
    ..registerLazySingleton<InternetProber>(
      () => InternetProber(httpClientProvider),
    )
    ..registerSingleton<ConnectivityCubit>(
      ConnectivityCubit(getIt<InternetProber>()),
    );

  final connectivityCubit = getIt<ConnectivityCubit>();
  await connectivityCubit.initialize();
}
