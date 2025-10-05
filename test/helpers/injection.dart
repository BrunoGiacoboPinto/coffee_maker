import 'package:coffee_maker/di/injection.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class MockDio extends Mock implements Dio {}

class MockInternetProber extends Mock implements InternetProber {}

class MockConnectivityCubit extends Mock implements ConnectivityCubit {}

Future<void> configureTestDependencies() async {
  await getIt.reset();

  getIt
    ..registerLazySingleton<InternetProber>(MockInternetProber.new)
    ..registerFactory<ConnectivityCubit>(MockConnectivityCubit.new);
}

Future<void> resetTestDependencies() async {
  await getIt.reset();
}
