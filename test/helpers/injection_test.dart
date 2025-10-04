import 'package:coffee_maker/core/network/api_client.dart';
import 'package:coffee_maker/counter/cubit/counter_cubit.dart';
import 'package:coffee_maker/di/injection.dart';
import 'package:network/network.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockDio extends Mock implements Dio {}

class MockInternetProber extends Mock implements InternetProber {}

class MockConnectivityCubit extends Mock implements ConnectivityCubit {}

class MockCounterCubit extends Mock implements CounterCubit {}

class MockHttpClientProvider extends Mock implements HttpClientProvider {}

class MockApiClient extends Mock implements ApiClient {}

void configureTestDependencies() {
  // Reset GetIt instance
  getIt.reset();

  // Register mock implementations
  getIt
    ..registerLazySingleton<HttpClientProvider>(MockHttpClientProvider.new)
    ..registerLazySingleton<ApiClient>(MockApiClient.new)
    ..registerLazySingleton<InternetProber>(MockInternetProber.new)
    ..registerFactory<ConnectivityCubit>(MockConnectivityCubit.new)
    ..registerFactory<CounterCubit>(MockCounterCubit.new);
}

void resetTestDependencies() {
  getIt.reset();
}
