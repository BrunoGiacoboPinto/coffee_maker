import 'package:coffee_maker/coffee_photo_details/coffee_photo_details.dart';
import 'package:coffee_maker/di/injection.config.dart';
import 'package:coffee_maker/home/bloc/home_bloc.dart';
import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:dio/dio.dart';
import 'package:environment/environment.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart' hide Environment;
import 'package:network/network.dart';
import 'package:path_provider/path_provider.dart';

final GetIt getIt = GetIt.instance;

const _kPhotosBoxName = 'photos';

@InjectableInit()
Future<void> configureDependencies() async {
  getIt.init();

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiBaseUrl,
      connectTimeout: const Duration(seconds: Environment.connectTimeout),
      receiveTimeout: const Duration(seconds: Environment.receiveTimeout),
    ),
  );

  final directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(CoffeePhotoDataAdapter());

  final photosBox = await Hive.openBox<CoffeePhotoData>(_kPhotosBoxName);
  final httpClientProvider = HttpClientProvider();

  getIt
    ..registerLazySingleton<Dio>(() => dio)
    ..registerLazySingleton<CoffeePhotosService>(() => CoffeePhotosService(dio))
    ..registerLazySingleton<CoffeePhotosRepository>(
      () => CoffeePhotosRepository(
        coffeePhotosService: getIt<CoffeePhotosService>(),
        photosBox: photosBox,
      ),
    )
    ..registerFactory<HomeBloc>(
      () => HomeBloc(
        coffeePhotosRepository: getIt<CoffeePhotosRepository>(),
      ),
    )
    ..registerFactory<CoffeePhotoDetailsBloc>(
      () => CoffeePhotoDetailsBloc(
        coffeePhotosRepository: getIt<CoffeePhotosRepository>(),
      ),
    )
    ..registerLazySingleton<Box<CoffeePhotoData>>(() => photosBox)
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
