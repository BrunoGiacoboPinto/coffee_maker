import 'package:coffee_maker/coffee_photo_details/coffee_photo_details.dart';
import 'package:coffee_maker/di/injection.config.dart';
import 'package:coffee_maker/favorites/bloc/favorites_bloc.dart';
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

  getIt
    ..registerLazySingleton<Dio>(() => dio, dispose: (dio) => dio.close())
    ..registerLazySingleton<Box<CoffeePhotoData>>(
      () => photosBox,
      dispose: (box) => box.close(),
    )
    ..registerLazySingleton<CoffeePhotosService>(() => CoffeePhotosService(dio))
    ..registerLazySingleton<CoffeePhotosRepository>(
      () => CoffeePhotosRepository(
        coffeePhotosService: getIt<CoffeePhotosService>(),
        photosBox: photosBox,
      ),
      dispose: (repository) => repository.dispose(),
    )
    ..registerLazySingleton<HomeBloc>(
      () => HomeBloc(
        coffeePhotosRepository: getIt<CoffeePhotosRepository>(),
      ),
      dispose: (bloc) => bloc.close(),
    )
    ..registerLazySingleton<FavoritesBloc>(
      () => FavoritesBloc(
        coffeePhotosRepository: getIt<CoffeePhotosRepository>(),
      ),
      dispose: (bloc) => bloc.close(),
    )
    ..registerLazySingleton<CoffeePhotoDetailsBloc>(
      () => CoffeePhotoDetailsBloc(
        coffeePhotosRepository: getIt<CoffeePhotosRepository>(),
      ),
      dispose: (bloc) => bloc.close(),
    )
    ..registerLazySingleton<InternetProber>(
      () => InternetProber(getIt<Dio>()),
    )
    ..registerSingleton<ConnectivityCubit>(
      ConnectivityCubit(getIt<InternetProber>()),
      dispose: (cubit) => cubit.close(),
    );

  final connectivityCubit = getIt<ConnectivityCubit>();
  await connectivityCubit.initialize();
}
