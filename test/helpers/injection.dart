import 'package:coffee_maker/coffee_photo_details/bloc/coffee_photo_details_bloc.dart';
import 'package:coffee_maker/di/injection.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class MockDio extends Mock implements Dio {}

class MockInternetProber extends Mock implements InternetProber {}

class MockConnectivityCubit extends Mock implements ConnectivityCubit {}

class MockCoffeePhotoDetailsBloc extends Mock
    implements CoffeePhotoDetailsBloc {}

Future<void> configureTestDependencies() async {
  await getIt.reset();

  getIt
    ..registerLazySingleton<InternetProber>(MockInternetProber.new)
    ..registerFactory<ConnectivityCubit>(MockConnectivityCubit.new)
    ..registerFactory<CoffeePhotoDetailsBloc>(MockCoffeePhotoDetailsBloc.new);
}

Future<void> resetTestDependencies() async {
  await getIt.reset();
}
